`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

//interface for mux
interface mux_if();
  logic [3:0] i;
  logic [1:0] sel;
  logic y;
endinterface

//transcation class from uvm_seq_item
class transaction extends uvm_sequence_item;
  rand bit [3:0] i;
  rand bit [1:0] sel;
  bit y;
 //constructor for transcation class
  function new(string name="transaction");
    super.new(name);
  endfunction
  //object registration using field marcos
  `uvm_object_utils_begin(transaction)
    `uvm_field_int(i,   UVM_DEFAULT | UVM_BIN)
    `uvm_field_int(sel, UVM_DEFAULT | UVM_BIN)
    `uvm_field_int(y,   UVM_DEFAULT | UVM_BIN)
  `uvm_object_utils_end
endclass

//class generator extends from uvm sequence
class generator extends uvm_sequence #(transaction);
//object registration in uvm factory
  `uvm_object_utils(generator)
  transaction tx;  
//constructor for generator
  function new(string name="generator");
    super.new(name);
  endfunction
//task body for creating memory for object tx
  task body();
    tx=transaction::type_id::create("tx");
    repeat(5) begin
      start_item(tx);
      assert(tx.randomize());
      `uvm_info("GEN",
                $sformatf("Generated i=%04b sel=%02b", tx.i, tx.sel),
        UVM_MEDIUM);
      finish_item(tx);
    end
  endtask
endclass

//class driver extends from uvm driver
class driver extends uvm_driver #(transaction);
//component registration in uvm factory
  `uvm_component_utils(driver)
//Instantiation of virtual interface into driver for applying stimuls to DUT
  virtual mux_if vif;
  transaction tx;   
 //constructor for driver class
  function new(string name="driver", uvm_component parent);
    super.new(name,parent);
  endfunction
 //build phase in driver 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx=transaction::type_id::create("tx");
    if(!uvm_config_db #(virtual mux_if)::get(this,"","vif",vif))
      `uvm_error("DRV","Virtual interface not found")
  endfunction
//run phase in driver
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(tx);
      vif.i<=tx.i;
      vif.sel<=tx.sel;
      `uvm_info("DRV",
                $sformatf("Driving i=%04b sel=%02b",tx.i,tx.sel),
        UVM_MEDIUM);
      seq_item_port.item_done();
      #10;
    end
  endtask
endclass
    
//class monitor is extends from uvm monitor to     
class monitor extends uvm_monitor;
//component registration in uvm factory
  `uvm_component_utils(monitor)
//instatination of virtual interface in monitor to collect output from DUT
  virtual mux_if vif;
  //analysis port from monitor to scoreboard
  uvm_analysis_port #(transaction)ap;
  transaction tx;
//constructor for monitor and memory allocation for analysis port
  function new(string name="monitor", uvm_component parent);
    super.new(name,parent);
    ap = new("ap",this);
  endfunction
//build phase for monitor 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx = transaction::type_id::create("tx");
    //checking output data is avalible in virtual intetface or not
    if(!uvm_config_db #(virtual mux_if)::get(this,"","vif",vif))
      `uvm_error("MON","Virtual interface not found")
  endfunction
//run phase for monitor
  task run_phase(uvm_phase phase);

    //collecting output data from virtual interface
    forever begin
      #10;
      tx.i=vif.i;
      tx.sel=vif.sel;
      tx.y=vif.y;
      `uvm_info("MON",$sformatf("Sampled i=%04b sel=%02b y=%0b",tx.i,tx.sel,tx.y),UVM_MEDIUM);
      //writing data to scoreboard 
      ap.write(tx);
    end
  endtask
endclass
    
//class scoreboard extends from uvm scoreboard    
class scoreboard extends uvm_scoreboard;
//component registration in uvm factory for sb
  `uvm_component_utils(scoreboard)
//implementation port for analyis port for getting data from monitor
  uvm_analysis_imp #(transaction, scoreboard) imp;
  transaction tx_sb;  
//construtor for scoreboard and memory for implemetation port
  function new(string name="scoreboard", uvm_component parent);
    super.new(name,parent);
    imp = new("imp",this);
  endfunction
//build phase for scoreboard
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx_sb = transaction::type_id::create("tx_sb");
  endfunction
//write function for getting data from monitor to score board
  function void write(transaction tx);
     bit expected;
    tx_sb.copy(tx);  // tx_sb=tx;
    //storing expected output
    expected = tx_sb.i[tx_sb.sel];
    //comparing expecting with actual output
    if(expected==tx_sb.y)
      `uvm_info("SB",$sformatf("PASS i=%04b sel=%02b y=%0b",tx_sb.i,tx_sb.sel,tx_sb.y),UVM_LOW)
    else
      `uvm_error("SB",$sformatf("FAIL expected=%0b got=%0b",expected,tx_sb.y));
  endfunction
endclass
    
//class for agent extends from uvm agent    
class agent extends uvm_agent;
  // component registration in uvm factory for agent
  `uvm_component_utils(agent)
//handles for classes of driver and monitor
//here sequencer is automated working behaviour so we are giving the transcation to uvm_sequencer it drives to driver by connceting TLM Port in connect phase in agent
  driver drv;
  monitor mon;
  uvm_sequencer #(transaction) seqr;
  //constructor for agent
  function new(string name="agent", uvm_component parent);
    super.new(name,parent);
  endfunction
//build phase for agent creating memories for drv,mon,seqr
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv  = driver::type_id::create("drv",this);
    mon  = monitor::type_id::create("mon",this);
    seqr = uvm_sequencer #(transaction)::type_id::create("seqr",this);
  endfunction
//connect phase in agent connceting sequencer and driver through TLM port
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
endclass
    
//class for environment extends form uvm environment
class env extends uvm_env;
  //component registration in uvm factory
  `uvm_component_utils(env)
//handles for agent and scoreboard 
  agent ag;
  scoreboard sb;
//constructor for env
  function new(string name="env", uvm_component parent);
    super.new(name,parent);
  endfunction
//build phase for agent creating memories for agent and scoreboard , where the monitor inside the agent will be conneted to scoreboard using Analysis port conncetion
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ag = agent::type_id::create("ag",this);
    sb = scoreboard::type_id::create("sb",this);
  endfunction
//connect phase for env , monitor inside agent is connected with scoreboard implemetation port
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ag.mon.ap.connect(sb.imp);
  endfunction
endclass
    
//class test extends from uvm test    
class test extends uvm_test;
//component registration in uvm factory
  `uvm_component_utils(test)
//handles for environment and generator , in env the generator will start the stimulus generation
  env e;
  generator gen;
//constructor for environment
  function new(string name="test", uvm_component parent);
    super.new(name,parent);
  endfunction
//build phase for environment where the env and generator memories are created
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e   = env::type_id::create("e",this);
    gen = generator::type_id::create("gen");
  endfunction
//run phase in env , where the gen start generating stimuls between phasie raise and phasie drop
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    gen.start(e.ag.seqr);
    #20;
    phase.drop_objection(this);
  endtask
endclass   
    
    
module top;
  //virutal interface
  mux_if vif();
  //instation of dut 
  mux4to1 dut(.i(vif.i),.sel(vif.sel),.y(vif.y));
  initial begin
    uvm_config_db #(virtual mux_if)::set(null,"uvm_test_top.e.ag*","vif",vif);
//running test 
    run_test("test");
  end
endmodule    
