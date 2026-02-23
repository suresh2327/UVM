`include "uvm_macros.svh"
import uvm_pkg::*;
`include "alu_modes.sv"

//interface
interface alu_inf;
  logic [31:0] a;
  logic [31:0] b;
  alu_mode     sel_mode;
  logic [31:0] result;
  logic        carry;
endinterface

//transaction class
class transaction extends uvm_sequence_item;
  rand bit [31:0]a;
  rand bit [31:0]b;
  rand alu_mode sel_mode;
  bit [31:0]result;
  bit carry;
  //constructor
  function new(string path="transaction");
    super.new(path);
  endfunction
  //object registration using field marcos
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(a,UVM_DEFAULT | UVM_DEC)
  `uvm_field_int(b,UVM_DEFAULT | UVM_DEC)
  `uvm_field_enum(alu_mode,sel_mode,UVM_DEFAULT)
  `uvm_field_int(result,UVM_DEFAULT | UVM_DEC)
  `uvm_field_int(carry, UVM_DEFAULT)
  `uvm_object_utils_end
endclass

//generator
class generator extends uvm_sequence #(transaction);
  `uvm_object_utils(generator)
  transaction tx;
//constructor
  function new(string path="generator");
    super.new(path);
  endfunction
//generating stimuls
  task body();
    tx = transaction::type_id::create("tx");
    repeat(10) begin
      start_item(tx);
      assert(tx.randomize());
      `uvm_info("GEN",
        $sformatf("a=%0d, b=%0d, MODE=%s",tx.a,tx.b, tx.sel_mode.name()),UVM_LOW)
      finish_item(tx);
    end
  endtask
endclass

//driver
class driver extends uvm_driver #(transaction);
  `uvm_component_utils(driver);
  //constructor
  function new(string path="driver",uvm_component parent=null);
    super.new(path,parent);
  endfunction
  
  transaction tx;
  //virtual interface
  virtual alu_inf vif;
  //build phase for driver
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx=transaction::type_id::create("tx");
    if(!uvm_config_db #(virtual alu_inf)::get(this,"","vif",vif))
       `uvm_error("DRI","Driver unable to access virtual interface");
  endfunction
  //run phase for driver     
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(tx);
      vif.a<=tx.a;
      vif.b<=tx.b;
      vif.sel_mode<=tx.sel_mode; `uvm_info("DRI",$sformatf("a=%0d,b=%0d,sel_mode=%s",tx.a,tx.b,tx.sel_mode.name()),UVM_NONE);
      seq_item_port.item_done();
      #10;
    end
  endtask
endclass
 
//monitor
class monitor extends uvm_monitor;
  `uvm_component_utils(monitor);
  //construcor
  function new(string path="monitor",uvm_component parent=null);
    super.new(path,parent);
  endfunction
  //analysis port
  uvm_analysis_port #(transaction) send;
  transaction tx;
  virtual alu_inf vif;
  //build phase for monitor
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx=transaction::type_id::create("tx");
    send=new("send",this);
    if(!uvm_config_db #(virtual alu_inf)::get(this,"","vif",vif))
      `uvm_error("MON","Monitor unable to acces virtual interface");
  endfunction
  //run phase for monitor
  virtual task run_phase(uvm_phase phase);
    forever begin
      #10;
      tx.a=vif.a;
      tx.b=vif.b;
      tx.sel_mode=vif.sel_mode;
      tx.result=vif.result;
      tx.carry=vif.carry;
      `uvm_info("MON",$sformatf("a=%0d,b=%0d,sel_mode=%s,result=%0d,carry=%0b",tx.a,tx.b,tx.sel_mode.name(),tx.result,tx.carry),UVM_NONE);
      send.write(tx);
    end
  endtask
endclass

//scoreboard 
class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard);
  uvm_analysis_imp #(transaction,scoreboard) recv;
  transaction tx_sb;
  //constructor
  function new(string path="scoreboard",uvm_component parent=null);
    super.new(path,parent);
  endfunction
  //build phase for monitor
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx_sb=transaction::type_id::create("tx_sb");
    recv=new("recv",this);
  endfunction
  //write function 
  virtual function void write (input transaction tx);
    
    //reference model logic
    bit [31:0]expected_result;
    bit expected_carry;
    bit [32:0] result_ext;
    expected_result=0;
    expected_carry=0;
    result_ext=0;
    //deep copy of handle
    tx_sb.copy(tx); `uvm_info("SB",$sformatf("a=%0d,b=%0d,sel_mode=%s,result=%0d,carry=%0b",tx_sb.a,tx_sb.b,tx_sb.sel_mode.name(),tx_sb.result,tx_sb.carry),UVM_NONE);
    //ref logic comparing with actual ooutput
    case(tx_sb.sel_mode)
      ALU_ADD: begin
        result_ext=tx_sb.a+tx_sb.b;
        expected_result=result_ext[31:0];
        expected_carry=result_ext[32];
      end

      ALU_SUB: begin
        result_ext=tx_sb.a-tx_sb.b;
        expected_result=result_ext[31:0];
        expected_carry=result_ext[32];
      end

      ALU_AND: expected_result=tx_sb.a&tx_sb.b;
      ALU_OR : expected_result=tx_sb.a|tx_sb.b;
      ALU_XOR: expected_result=tx_sb.a^tx_sb.b;
      ALU_SLL: expected_result=tx_sb.a<<tx_sb.b[$clog2(32)-1:0];
      ALU_SRL: expected_result=tx_sb.a>>tx_sb.b[$clog2(32)-1:0];
      ALU_MUL: expected_result=tx_sb.a*tx_sb.b;
    endcase
    if(expected_result!==tx_sb.result || expected_carry!==tx_sb.carry)
    begin
      `uvm_error("REF",$sformatf("FAIL: a=%0d b=%0d mode=%s | exp_res=%0d act_res=%0d",tx_sb.a, tx_sb.b, tx_sb.sel_mode.name(),expected_result, tx_sb.result))
    end
    else begin
      `uvm_info("REF",$sformatf("PASS: mode=%s result=%0d",tx_sb.sel_mode.name(), tx_sb.result),UVM_LOW)
    end
  endfunction
endclass
    
//agent
class agent extends uvm_agent;
  `uvm_component_utils(agent);
  //construtor
  function new(string path="agent",uvm_component parent=null);
    super.new(path,parent);
  endfunction
  driver div;
  monitor mon;
  uvm_sequencer #(transaction) seqr;
  //build phase for agent
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    div=driver::type_id::create("div",this);
    mon=monitor::type_id::create("mon",this);
    seqr=uvm_sequencer #(transaction)::type_id::create("seqr",this);
  endfunction
  //connect phase for agent
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    div.seq_item_port.connect(seqr.seq_item_export);
  endfunction
endclass

//environment
class env extends uvm_env;
  `uvm_component_utils(env);
  //constructor
  function new(string path="env",uvm_component parent=null);
    super.new(path,parent);
  endfunction
  
  agent ag;
  scoreboard sb;
  
  //build phase for env
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ag=agent::type_id::create("ag",this);
    sb=scoreboard::type_id::create("sb",this);
  endfunction
  //connect phase for env
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ag.mon.send.connect(sb.recv);
  endfunction
endclass

//test
class test extends uvm_test;
  `uvm_component_utils(test);
  //constructor
  function new(string path="test",uvm_component parent=null);
    super.new(path,parent);
  endfunction
  
  generator gen;
  env e;
  //build phase for test
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    gen=generator::type_id::create("gen",this);
    e=env::type_id::create("e",this);
  endfunction
  //run phase for test
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    gen.start(e.ag.seqr);
    #10;
    phase.drop_objection(this);
  endtask
endclass

//top module
module top();
  alu_inf vif();
  alu u1(.a(vif.a),.b(vif.b),.sel_mode(vif.sel_mode),.result(vif.result),.carry(vif.carry));
  initial
    begin
      uvm_config_db #(virtual alu_inf)::set(null,"uvm_test_top.e.ag*","vif",vif);
      run_test("test");
    end
  initial
    begin
      $dumpfile("waveforms.vcd");
      $dumpvars;
    end
endmodule
      
  

    
    
    
      
      

  