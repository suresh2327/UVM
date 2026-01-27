//uvm code for displaying the string and interger value using `um_info

`include "uvm_macros.svh" //sv based useed to invoke the uvm_macros
import uvm_pkg::*; // used to involve the classes

module tb;
  initial
    begin
      int data=100;
      #10;
      $display("HELLO VLSI");
      `uvm_info("Top_tb","HELLO VLSI",UVM_LOW);
      #20;
      `uvm_info("Top_tb",$sformatf("value of data=%0d",data),UVM_LOW);
    end
endmodule

//output
# KERNEL: HELLO VLSI
# KERNEL: UVM_INFO /home/runner/testbench.sv(12) @ 10: reporter [Top_tb] HELLO VLSI
# KERNEL: UVM_INFO /home/runner/testbench.sv(14) @ 30: reporter [Top_tb] value of data=100

//uvm code for getting default verbosity level

`include "uvm_macros.svh"
import uvm_pkg::*;
module tb;
  initial
    begin
      int verb;
      verb=uvm_top.get_report_verbosity_level();
      `uvm_info("verbosity",$sformatf("default verbosity level=%0d",verb),UVM_LOW);
    end
endmodule

//output
# KERNEL: UVM_INFO /home/runner/testbench.sv(9) @ 0: reporter [verbosity] default verbosity level=200

//uvm code for setting and getting  verbosity level
`include "uvm_macros.svh"
import uvm_pkg::*;
module tb;
  initial
    begin
      int verb; 
      //default verbosity
      verb=uvm_top.get_report_verbosity_level();
      `uvm_info("verbosity",$sformatf("default verbosity level=%0d",verb),UVM_LOW);
      //setting verbosity to 400
      uvm_top.set_report_verbosity_level(400);
      verb=uvm_top.get_report_verbosity_level();
      `uvm_info("verbosity",$sformatf("after setting verbosity level=%0d",verb),UVM_LOW);
    end
endmodule

//output
# KERNEL: UVM_INFO /home/runner/testbench.sv(10) @ 0: reporter [verbosity] default verbosity level=200
# KERNEL: UVM_INFO /home/runner/testbench.sv(14) @ 0: reporter [verbosity] after setting verbosity level=400



//severity concept of info, error, warning
`include "uvm_macros.svh"
import uvm_pkg::*;
module tb;
  initial
    begin
      `uvm_info("top_tb","info message",UVM_NONE);
      `uvm_error("top_tb","error message");
      `uvm_warning("top_tb","warning message");
    end
endmodule

//output
# KERNEL: UVM_INFO /home/runner/testbench.sv(10) @ 0: reporter [top_tb] info message
# KERNEL: UVM_ERROR /home/runner/testbench.sv(11) @ 0: reporter [top_tb] error message
# KERNEL: UVM_WARNING /home/runner/testbench.sv(12) @ 0: reporter [top_tb] warning message




//NO_ACTION , EXIT in severity for controlling
//NO_ACTION : runs simulation , but not printed in console

`include "uvm_macros.svh"
import uvm_pkg::*;

module tb;
  initial
    begin
      uvm_top.set_report_severity_action(UVM_WARNING,UVM_NO_ACTION);
      `uvm_info("top_tb","info message",UVM_NONE);
      `uvm_error("top_tb","error message");
      `uvm_warning("top_tb","warning message");
    end
endmodule

//output
# KERNEL: UVM_INFO /home/runner/testbench.sv(10) @ 0: reporter [top_tb] info message
# KERNEL: UVM_ERROR /home/runner/testbench.sv(11) @ 0: reporter [top_tb] error message


// UVM_EXIT : stops simualtion
`include "uvm_macros.svh"
import uvm_pkg::*;

module tb;
  initial
    begin
      uvm_top.set_report_severity_action(UVM_WARNING,UVM_EXIT);
      `uvm_info("top_tb","info message",UVM_NONE);
      `uvm_error("top_tb","error message");
      `uvm_warning("top_tb","warning message");
    end
endmodule

//output
# KERNEL: UVM_INFO /home/runner/testbench.sv(10) @ 0: reporter [top_tb] info message
# KERNEL: UVM_ERROR /home/runner/testbench.sv(11) @ 0: reporter [top_tb] error message
# KERNEL: UVM_INFO /home/build/vlib1/vlib/uvm-1.2/src/base/uvm_report_server.svh(869) @ 0: reporter [UVM/REPORT/SERVER] 
# KERNEL: --- UVM Report Summary ---
# KERNEL: 
# KERNEL: ** Report counts by severity
# KERNEL: UVM_INFO :    2
# KERNEL: UVM_WARNING :    1
# KERNEL: UVM_ERROR :    1
# KERNEL: UVM_FATAL :    0


//syntax for counting error , warnings

`include "uvm_macros.svh"
import uvm_pkg::*;
module tb;
  initial
    begin
      int err_count;
      `uvm_error("top_tb","error message1");
      `uvm_error("top_tb","error message2");
      `uvm_error("top_tb","error message3");
      //formula
      err_count=uvm_report_server::get_server().get_severity_count(UVM_ERROR);
      `uvm_info("top_tb",$sformatf("error count =%0d",err_count),UVM_NONE);
    end 
endmodule

//output
# KERNEL: UVM_ERROR /home/runner/testbench.sv(10) @ 0: reporter [top_tb] error message1
# KERNEL: UVM_ERROR /home/runner/testbench.sv(11) @ 0: reporter [top_tb] error message2
# KERNEL: UVM_ERROR /home/runner/testbench.sv(12) @ 0: reporter [top_tb] error message3
# KERNEL: UVM_INFO /home/runner/testbench.sv(14) @ 0: reporter [top_tb] error count =3

//same code for warings
// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;

module tb;
  initial
    begin
      int err_count;
      `uvm_error("top_tb","error message1");
      `uvm_error("top_tb","error message2");
      `uvm_error("top_tb","error message3");
      err_count=uvm_report_server::get_server().get_severity_count(UVM_WARNING);
      `uvm_info("top_tb",$sformatf("warning count =%0d",err_count),UVM_NONE);
    end
endmodule

//output
# KERNEL: UVM_ERROR /home/runner/testbench.sv(10) @ 0: reporter [top_tb] error message1
# KERNEL: UVM_ERROR /home/runner/testbench.sv(11) @ 0: reporter [top_tb] error message2
# KERNEL: UVM_ERROR /home/runner/testbench.sv(12) @ 0: reporter [top_tb] error message3
# KERNEL: UVM_INFO /home/runner/testbench.sv(14) @ 0: reporter [top_tb] warning count =0
//because there are no warning severity satements


//CREATING object and allocating memory
`include "uvm_macros.svh"
import uvm_pkg::*;

class vlsi extends uvm_object;
  `uvm_object_utils(vlsi);
  function new(string path="vlsi");
    super.new(path);
  endfunction
  rand bit[3:0]a;
endclass

module tb;
  vlsi v;
  initial
    begin
      v=new();
      repeat(10)begin
        assert( v.randomize());
      `uvm_info("top_tb",$sformatf("value of object=%0d",v.a),UVM_NONE);
      end
    end
endmodule

//output
# KERNEL: UVM_INFO /home/runner/testbench.sv(19) @ 0: reporter [top_tb] value of object=6
# KERNEL: UVM_INFO /home/runner/testbench.sv(19) @ 0: reporter [top_tb] value of object=5
# KERNEL: UVM_INFO /home/runner/testbench.sv(19) @ 0: reporter [top_tb] value of object=3
# KERNEL: UVM_INFO /home/runner/testbench.sv(19) @ 0: reporter [top_tb] value of object=4
# KERNEL: UVM_INFO /home/runner/testbench.sv(19) @ 0: reporter [top_tb] value of object=15
# KERNEL: UVM_INFO /home/runner/testbench.sv(19) @ 0: reporter [top_tb] value of object=13
# KERNEL: UVM_INFO /home/runner/testbench.sv(19) @ 0: reporter [top_tb] value of object=11
# KERNEL: UVM_INFO /home/runner/testbench.sv(19) @ 0: reporter [top_tb] value of object=8
# KERNEL: UVM_INFO /home/runner/testbench.sv(19) @ 0: reporter [top_tb] value of object=7
# KERNEL: UVM_INFO /home/runner/testbench.sv(19) @ 0: reporter [top_tb] value of object=8


//object regestartion with field marcos 
`include "uvm_macros.svh"
import uvm_pkg::*;

class vlsi extends uvm_object;
  // `uvm_object_utils(vlsi) using factor registarion 

  rand bit [7:0] a;
  rand bit [7:0] b;

  function new(string path = "vlsi");
    super.new(path);
  endfunction
  `uvm_object_utils_begin(vlsi) //object registration
  `uvm_field_int(a, UVM_STRING)   //object creating with field marcos 
    `uvm_field_int(b,UVM_DEFAULT)
  `uvm_object_utils_end
endclass


module tb;
  vlsi v;
  initial begin
    v = new("vlsi");
    v.randomize();
    // `uvm_info("Top_tb",
    //            $sformatf(" value of object=%0d", v.a),  //using uvm info
    //            UVM_NONE);
    v.print(uvm_default_tree_printer); //using macros print it is possible only when we register object with filed marcos 3 line syntax
  end
endmodule



//UVM PRINT METHODS AND FLAGS
`include "uvm_macros.svh"
import uvm_pkg::*;

class vlsi extends uvm_object;
  // `uvm_object_utils(vlsi) using factor registarion 

  rand bit [7:0] a;
  //rand bit [7:0] b;

  function new(string path = "vlsi");
    super.new(path);
  endfunction
  `uvm_object_utils_begin(vlsi)
  `uvm_field_int(a, UVM_DEFAULT)//object registration
  `uvm_field_int(a, UVM_DEC)   //object creating with field marcos 
  `uvm_field_int(a,UVM_OCT)
  `uvm_field_int(a, UVM_HEX)
  `uvm_field_int(a, UVM_BIN)
   `uvm_field_int(a, UVM_STRING)
  `uvm_field_int(a, UVM_TIME)
  `uvm_object_utils_end
endclass


module tb;
  vlsi v;
  initial begin
    v = new("vlsi");
    v.randomize();
    //using macros print it is possible only when we register object with filed marcos 3 line syntax
    v.print(); //default table
    v.print(uvm_default_line_printer);
    v.print(uvm_default_tree_printer);
  end
endmodule

//output;
# KERNEL: -------------------------------
# KERNEL: Name  Type      Size  Value    
# KERNEL: -------------------------------
# KERNEL: vlsi  vlsi      -     @335     
# KERNEL:   a   integral  8     'h46     
# KERNEL:   a   integral  8     'd70     
# KERNEL:   a   integral  8     'o106    
# KERNEL:   a   integral  8     'h46     
# KERNEL:   a   integral  8     'b1000110
# KERNEL:   a   string    8     F        
# KERNEL:   a   time      8     70       
# KERNEL: -------------------------------
# KERNEL: vlsi: (vlsi@335) { a: 'h46  a: 'd70  a: 'o106  a: 'h46  a: 'b1000110  a: F  a: 70  } 
# KERNEL: vlsi: (vlsi@335) {
# KERNEL:   a: 'h46 
# KERNEL:   a: 'd70 
# KERNEL:   a: 'o106 
# KERNEL:   a: 'h46 
# KERNEL:   a: 'b1000110 
# KERNEL:   a: F 
# KERNEL:   a: 70 
# KERNEL: }




//NO COPY flag
`include "uvm_macros.svh"
import uvm_pkg::*;

class vlsi extends uvm_object;
  // `uvm_object_utils(vlsi) using factor registarion 

  rand bit [7:0] a;
  rand bit [7:0] b;

  function new(string path = "vlsi");
    super.new(path);
  endfunction
  `uvm_object_utils_begin(vlsi) //object registration
  `uvm_field_int(a, UVM_NOCOPY | UVM_BIN)   //object creating with field marcos 
  `uvm_field_int(b,UVM_DEFAULT)
  `uvm_object_utils_end
endclass


module tb;
  vlsi v,v1;
 
  initial begin
    v = new("vlsi");
    v1 = new("v1");
    v.randomize();
    v1.copy(v);
    v.print();
    v1.print();
  
  end
endmodule

//output
# KERNEL: -------------------------------
# KERNEL: Name  Type      Size  Value    
# KERNEL: -------------------------------
# KERNEL: vlsi  vlsi      -     @335     
# KERNEL:   a   integral  8     'b1000110
# KERNEL:   b   integral  8     'ha5     
# KERNEL: -------------------------------
# KERNEL: ---------------------------
# KERNEL: Name  Type      Size  Value
# KERNEL: ---------------------------
# KERNEL: v1    vlsi      -     @336 
# KERNEL:   a   integral  8     'b0  
# KERNEL:   b   integral  8     'ha5 
# KERNEL: ---------------------------


//NOCOMPARE FLAG
`include "uvm_macros.svh"
import uvm_pkg::*;

class vlsi extends uvm_object;
  // `uvm_object_utils(vlsi) using factor registarion 

  rand bit [7:0] a;
  rand bit [7:0] b;

  function new(string path = "vlsi");
    super.new(path);
  endfunction
  `uvm_object_utils_begin(vlsi) //object registration
  `uvm_field_int(a, UVM_NOCOMPARE | UVM_DEC)   //object creating with field marcos 
  `uvm_field_int(b,UVM_DEC)
  `uvm_object_utils_end
endclass


module tb;
  vlsi v1,v2;
  bit x;
  initial begin
    v1 = new("v1");
    v2 = new("v2");
    v1.randomize();
    v2.randomize();
    v2.a=~v1.a;
    v2.b=v1.b;
    x=v2.compare(v1);
    v1.print();
    v2.print();
     $display("x=%0b",x);
    if(x)
      $display("DONE");
    else
      $display("FAIL");
  end
endmodule
//output even a values is not same , our comparsion success , why because a is defined with no compare
# KERNEL: ---------------------------
# KERNEL: Name  Type      Size  Value
# KERNEL: ---------------------------
# KERNEL: v1    vlsi      -     @335 
# KERNEL:   a   integral  8     'd70 
# KERNEL:   b   integral  8     165  
# KERNEL: ---------------------------
# KERNEL: ---------------------------
# KERNEL: Name  Type      Size  Value
# KERNEL: ---------------------------
# KERNEL: v2    vlsi      -     @336 
# KERNEL:   a   integral  8     185  
# KERNEL:   b   integral  8     165  
# KERNEL: ---------------------------
# KERNEL: x=1
# KERNEL: DONE

//same code without NOCOMPARE
`include "uvm_macros.svh"
import uvm_pkg::*;

class vlsi extends uvm_object;
  // `uvm_object_utils(vlsi) using factor registarion 

  rand bit [7:0] a;
  rand bit [7:0] b;

  function new(string path = "vlsi");
    super.new(path);
  endfunction
  `uvm_object_utils_begin(vlsi) //object registration
  `uvm_field_int(a, UVM_DEFAULT | UVM_DEC)   //object creating with field marcos 
  `uvm_field_int(b,UVM_DEC)
  `uvm_object_utils_end
endclass


module tb;
  vlsi v1,v2;
  bit x;
  initial begin
    v1 = new("v1");
    v2 = new("v2");
    v1.randomize();
    v2.randomize();
    v2.a=~v1.a;
    v2.b=v1.b;
    x=v2.compare(v1);
    v1.print();
    v2.print();
     $display("x=%0b",x);
    if(x)
      $display("DONE");
    else
      $display("FAIL");
  end
endmodule
//output
# KERNEL: ---------------------------
# KERNEL: Name  Type      Size  Value
# KERNEL: ---------------------------
# KERNEL: v1    vlsi      -     @335 
# KERNEL:   a   integral  8     'd70 
# KERNEL:   b   integral  8     165  
# KERNEL: ---------------------------
# KERNEL: ---------------------------
# KERNEL: Name  Type      Size  Value
# KERNEL: ---------------------------
# KERNEL: v2    vlsi      -     @336 
# KERNEL:   a   integral  8     185  
# KERNEL:   b   integral  8     165  
# KERNEL: ---------------------------
# KERNEL: x=0
# KERNEL: FAIL


//Field marcos for string , real , enum
`include "uvm_macros.svh"
import uvm_pkg::*;

class vlsi extends uvm_object;
     string str="Hello";
      real temp=14.25;
  typedef enum bit [1:0]{s0,s1,s2,s3}state_type;
  rand state_type state;
  
  function new(string path = "vlsi");
    super.new(path);
  endfunction
  
  `uvm_object_utils_begin(vlsi) 
  `uvm_field_string(str,UVM_DEFAULT)  
  `uvm_field_real(temp,UVM_DEFAULT)
  `uvm_field_enum(state_type,state,UVM_DEFAULT)
  `uvm_object_utils_end
endclass

module tb;
  vlsi v1;
  bit x;
  initial begin
    v1 = new("v1");
    assert(v1.randomize());
    v1.print();
  end
endmodule

//output
# KERNEL: ------------------------------------
# KERNEL: Name     Type        Size  Value    
# KERNEL: ------------------------------------
# KERNEL: v1       vlsi        -     @335     
# KERNEL:   str    string      5     Hello    
# KERNEL:   temp   real        64    14.250000
# KERNEL:   state  state_type  2     s2       
# KERNEL: ------------------------------------

//field macros for arrays , static , dynamic , queue
`include "uvm_macros.svh"
import uvm_pkg::*;

class vlsi extends uvm_object;

  int sarr[5] ={1,2,3,4,5};
  int arr[];
  int que[$];
  int asso[int];

  function new(string name = "vlsi");
    super.new(name);

  endfunction

  `uvm_object_utils_begin(vlsi)
    `uvm_field_sarray_int(sarr,UVM_DEFAULT)
    `uvm_field_array_int(arr,UVM_DEFAULT)
    `uvm_field_queue_int(que,UVM_DEFAULT)
    `uvm_field_aa_int_int(asso,UVM_DEFAULT)
  `uvm_object_utils_end
  
  task run();
    arr=new[3];
    arr[0]=3;
    arr[1]=3;
    arr[2]=0;
    que.push_front(1);
    que.push_front(2);
    asso[1]=5;
    asso[2]=8;
    asso[5]=0;
  endtask

endclass

module tb;
  vlsi v1;
  initial begin
    v1=new("v1");
    v1.run();
    v1.print();
  end
endmodule

//output
# KERNEL: ----------------------------------
# KERNEL: Name     Type          Size  Value
# KERNEL: ----------------------------------
# KERNEL: v1       vlsi          -     @335 
# KERNEL:   sarr   sa(integral)  5     -    
# KERNEL:     [0]  integral      32    'h1  
# KERNEL:     [1]  integral      32    'h2  
# KERNEL:     [2]  integral      32    'h3  
# KERNEL:     [3]  integral      32    'h4  
# KERNEL:     [4]  integral      32    'h5  
# KERNEL:   arr    da(integral)  3     -    
# KERNEL:     [0]  integral      32    'h3  
# KERNEL:     [1]  integral      32    'h3  
# KERNEL:     [2]  integral      32    'h0  
# KERNEL:   que    da(integral)  2     -    
# KERNEL:     [0]  integral      32    'h2  
# KERNEL:     [1]  integral      32    'h1  
# KERNEL:   asso   aa(int,int)   3     -    
# KERNEL:     [1]  integral      32    'h5  
# KERNEL:     [2]  integral      32    'h8  
# KERNEL:     [5]  integral      32    'h0  
# KERNEL: ----------------------------------



//inherited class of uvm field macros without object filed macros
`include "uvm_macros.svh"
import uvm_pkg::*;

class vlsi extends uvm_object;

  int sarr[5] ={1,2,3,4,5};
  int arr[];
  int que[$];
  int asso[int];

  function new(string name = "vlsi");
    super.new(name);

  endfunction

  `uvm_object_utils_begin(vlsi)
    `uvm_field_sarray_int(sarr,UVM_DEFAULT)
    `uvm_field_array_int(arr,UVM_DEFAULT)
    `uvm_field_queue_int(que,UVM_DEFAULT)
    `uvm_field_aa_int_int(asso,UVM_DEFAULT)
  `uvm_object_utils_end
  
  task run();
    arr=new[3];
    arr[0]=3;
    arr[1]=3;
    arr[2]=0;
    que.push_front(1);
    que.push_front(2);
    asso[1]=5;
    asso[2]=8;
    asso[5]=0;
  endtask

endclass


class child extends vlsi;

  function new(string name="child");
    super.new(name);
  endfunction

 `uvm_object_utils(child)
  
//   `uvm_object_utils_begin(child)
//   `uvm_field_object(vlsi,UVM_DEFAULT)
//   `uvm_object_utils_end
endclass


module tb;
  vlsi v1;
  child c1;

  initial begin
    v1=new("v1");
    c1=new("c1");
    c1.run();
    c1.print();
  end
endmodule

//output
# KERNEL: ----------------------------------
# KERNEL: Name     Type          Size  Value
# KERNEL: ----------------------------------
# KERNEL: c1       child         -     @336 
# KERNEL:   sarr   sa(integral)  5     -    
# KERNEL:     [0]  integral      32    'h1  
# KERNEL:     [1]  integral      32    'h2  
# KERNEL:     [2]  integral      32    'h3  
# KERNEL:     [3]  integral      32    'h4  
# KERNEL:     [4]  integral      32    'h5  
# KERNEL:   arr    da(integral)  3     -    
# KERNEL:     [0]  integral      32    'h3  
# KERNEL:     [1]  integral      32    'h3  
# KERNEL:     [2]  integral      32    'h0  
# KERNEL:   que    da(integral)  2     -    
# KERNEL:     [0]  integral      32    'h2  
# KERNEL:     [1]  integral      32    'h1  
# KERNEL:   asso   aa(int,int)   3     -    
# KERNEL:     [1]  integral      32    'h5  
# KERNEL:     [2]  integral      32    'h8  
# KERNEL:     [5]  integral      32    'h0  
# KERNEL: ----------------------------------

`include "uvm_macros.svh"
import uvm_pkg::*;

class parent extends uvm_object;
  rand bit [3:0] data;

  function new(string path = "parent");
    super.new(path);
  endfunction

  `uvm_object_utils_begin(parent)
    `uvm_field_int(data, UVM_DEFAULT)
  `uvm_object_utils_end
endclass


class child extends uvm_object;
  parent p;

  function new(string path = "child");
    super.new(path);
    p = new("parent");
  endfunction

  `uvm_object_utils_begin(child)
    `uvm_field_object(p, UVM_DEFAULT)
  `uvm_object_utils_end
endclass


module tb;
  child c;

  initial begin
    c = new("child");
    c.p.randomize();
    c.print();
  end
endmodule
//output
# KERNEL: -------------------------------
# KERNEL: Name      Type      Size  Value
# KERNEL: -------------------------------
# KERNEL: child     child     -     @335 
# KERNEL:   p       parent    -     @336 
# KERNEL:     data  integral  4     'h2  
# KERNEL: -------------------------------


//uvm COPY() field macro
`include "uvm_macros.svh"
import uvm_pkg::*;

class vlsi extends uvm_object;
  rand bit [1:0]data;
  function new(string path="vlsi");
    super.new(path);
  endfunction
  `uvm_object_utils_begin(vlsi)
  `uvm_field_int(data,UVM_DEFAULT);
  `uvm_object_utils_end
endclass

module tb;
  vlsi v1,v2;
  initial
    begin
      v1=new("v1"); //source
      v2=new("v2"); //target , here both s and t are created by user only in copy()
      assert(v1.randomize());
      v2.copy(v1);
      v1.print();
      v2.print();
    end
endmodule

//output
# KERNEL: -----------------------------
# KERNEL: Name    Type      Size  Value
# KERNEL: -----------------------------
# KERNEL: v1      vlsi      -     @335 
# KERNEL:   data  integral  2     'h2  
# KERNEL: -----------------------------
# KERNEL: -----------------------------
# KERNEL: Name    Type      Size  Value
# KERNEL: -----------------------------
# KERNEL: v2      vlsi      -     @336 
# KERNEL:   data  integral  2     'h2  
# KERNEL: -----------------------------

//clone() macro

`include "uvm_macros.svh"
import uvm_pkg::*;

class vlsi extends uvm_object;
  rand bit [1:0]data;
  function new(string path="vlsi");
    super.new(path);
  endfunction
  `uvm_object_utils_begin(vlsi)
  `uvm_field_int(data,UVM_DEFAULT);
  `uvm_object_utils_end
endclass

module tb;
  vlsi v1,v2;
  initial
    begin
      v1=new("v1");
      assert(v1.randomize());
      $cast(v2,v1.clone());
      v1.print();
      v2.print();
    end
endmodule

//here taget address are created by program it self in clone(), can cloned into multipple memory locations 
# KERNEL: -----------------------------
# KERNEL: Name    Type      Size  Value
# KERNEL: -----------------------------
# KERNEL: v1      vlsi      -     @335 
# KERNEL:   data  integral  2     'h2  
# KERNEL: -----------------------------
# KERNEL: -----------------------------
# KERNEL: Name    Type      Size  Value
# KERNEL: -----------------------------
# KERNEL: v1      vlsi      -     @336 
# KERNEL:   data  integral  2     'h2  
# KERNEL: -----------------------------

//same code with diffrent handles previously one handle name , use setmethod
`include "uvm_macros.svh"
import uvm_pkg::*;

class vlsi extends uvm_object;
  rand bit [1:0]data;
  function new(string path="vlsi");
    super.new(path);
  endfunction
  `uvm_object_utils_begin(vlsi)
  `uvm_field_int(data,UVM_DEFAULT);
  `uvm_object_utils_end
endclass

module tb;
  vlsi v1,v2;
  initial
    begin
      v1=new("v1");
      assert(v1.randomize());
      $cast(v2,v1.clone());
      v2.set_name("v2");
      v1.print();
      v2.print();
    end
endmodule

 //output
# KERNEL: -----------------------------
# KERNEL: Name    Type      Size  Value
# KERNEL: -----------------------------
# KERNEL: v1      vlsi      -     @335 
# KERNEL:   data  integral  2     'h2  
# KERNEL: -----------------------------
# KERNEL: -----------------------------
# KERNEL: Name    Type      Size  Value
# KERNEL: -----------------------------
# KERNEL: v2      vlsi      -     @336 
# KERNEL:   data  integral  2     'h2  
# KERNEL: -----------------------------            

//shallow copy code using inhertance concept , pointiing to same memory address chaing values
// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;

class parent extends uvm_object;
  rand bit [3:0] data;
  function new(string path="parent");
    super.new(path);
  endfunction
  
  `uvm_object_utils_begin(parent)
  `uvm_field_int(data,UVM_DEFAULT)
  `uvm_object_utils_end  
endclass

class child extends uvm_object;
  parent p;
  function new( string path="child");
    super.new(path);
    p=new("parent");
  endfunction
  
  `uvm_object_utils_begin(child)
  `uvm_field_object(p,UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

module tb;
  child c1,c2;
  initial 
    begin
      c1=new("c1");
      c2=new("c2");
      assert(c1.p.randomize());
      c2=c1; //shallow copy
      c1.print();
      c2.print();
      c2.p.data=12;
       c1.print();
      c2.print();
    end
endmodule
 //output
# KERNEL: -------------------------------
# KERNEL: Name      Type      Size  Value
# KERNEL: -------------------------------
# KERNEL: c1        child     -     @335 
# KERNEL:   p       parent    -     @336 
# KERNEL:     data  integral  4     'h2  
# KERNEL: -------------------------------
# KERNEL: -------------------------------
# KERNEL: Name      Type      Size  Value
# KERNEL: -------------------------------
# KERNEL: c1        child     -     @335 
# KERNEL:   p       parent    -     @336 
# KERNEL:     data  integral  4     'h2  
# KERNEL: -------------------------------
# KERNEL: -------------------------------
# KERNEL: Name      Type      Size  Value
# KERNEL: -------------------------------
# KERNEL: c1        child     -     @335 
# KERNEL:   p       parent    -     @336 
# KERNEL:     data  integral  4     'hc  
# KERNEL: -------------------------------
# KERNEL: -------------------------------
# KERNEL: Name      Type      Size  Value
# KERNEL: -------------------------------
# KERNEL: c1        child     -     @335 
# KERNEL:   p       parent    -     @336 
# KERNEL:     data  integral  4     'hc  
# KERNEL: -------------------------------

//deep copy concept
// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;

class parent extends uvm_object;
  rand bit [3:0] data;
  function new(string path="parent");
    super.new(path);
  endfunction
  
  `uvm_object_utils_begin(parent)
  `uvm_field_int(data,UVM_DEFAULT)
  `uvm_object_utils_end  
endclass

class child extends uvm_object;
  parent p;
  function new( string path="child");
    super.new(path);
    p=new("parent");
  endfunction
  
  `uvm_object_utils_begin(child)
  `uvm_field_object(p,UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

module tb;
  child c1,c2;
  initial 
    begin
      c1=new("c1");
      c2=new("c2");
      assert(c1.p.randomize());
      //c2=c1; //shallow copy
      c2.copy(c1); //deep copy
      c1.print();
      c2.print();
      c1.p.data=12;
       c1.print();
      c2.print();
    end
endmodule
//output
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: -------------------------------
# KERNEL: Name      Type      Size  Value
# KERNEL: -------------------------------
# KERNEL: c1        child     -     @335 
# KERNEL:   p       parent    -     @336 
# KERNEL:     data  integral  4     'h2  
# KERNEL: -------------------------------
# KERNEL: -------------------------------
# KERNEL: Name      Type      Size  Value
# KERNEL: -------------------------------
# KERNEL: c2        child     -     @337 
# KERNEL:   p       parent    -     @339 
# KERNEL:     data  integral  4     'h2  
# KERNEL: -------------------------------
# KERNEL: -------------------------------
# KERNEL: Name      Type      Size  Value
# KERNEL: -------------------------------
# KERNEL: c1        child     -     @335 
# KERNEL:   p       parent    -     @336 
# KERNEL:     data  integral  4     'hc  
# KERNEL: -------------------------------
# KERNEL: -------------------------------
# KERNEL: Name      Type      Size  Value
# KERNEL: -------------------------------
# KERNEL: c2        child     -     @337 
# KERNEL:   p       parent    -     @339 
# KERNEL:     data  integral  4     'h2  
# KERNEL: -------------------------------

//using clone for same code works as deep copy

`include "uvm_macros.svh"
import uvm_pkg::*;

class parent extends uvm_object;
  rand bit [3:0] data;
  function new(string path="parent");
    super.new(path);
  endfunction
  
  `uvm_object_utils_begin(parent)
  `uvm_field_int(data,UVM_DEFAULT)
  `uvm_object_utils_end  
endclass

class child extends uvm_object;
  parent p;
  function new( string path="child");
    super.new(path);
    p=new("parent");
  endfunction
  
  `uvm_object_utils_begin(child)
  `uvm_field_object(p,UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

module tb;
  child c1,c2;
  initial 
    begin
      c1=new("c1");
    //  c2=new("c2");
      assert(c1.p.randomize());
      //c2=c1; //shallow copy
     // c2.copy(c1); //deep copy
      $cast(c2,c1.clone());
      c1.print();
      c2.print();
      c1.p.data=12;
       c1.print();
      c2.print();
    end
endmodule
//output
# KERNEL: Name      Type      Size  Value
# KERNEL: -------------------------------
# KERNEL: c1        child     -     @335 
# KERNEL:   p       parent    -     @336 
# KERNEL:     data  integral  4     'h2  
# KERNEL: -------------------------------
# KERNEL: -------------------------------
# KERNEL: Name      Type      Size  Value
# KERNEL: -------------------------------
# KERNEL: c1        child     -     @337 
# KERNEL:   p       parent    -     @339 
# KERNEL:     data  integral  4     'h2  
# KERNEL: -------------------------------
# KERNEL: -------------------------------
# KERNEL: Name      Type      Size  Value
# KERNEL: -------------------------------
# KERNEL: c1        child     -     @335 
# KERNEL:   p       parent    -     @336 
# KERNEL:     data  integral  4     'hc  
# KERNEL: -------------------------------
# KERNEL: -------------------------------
# KERNEL: Name      Type      Size  Value
# KERNEL: -------------------------------
# KERNEL: c1        child     -     @337 
# KERNEL:   p       parent    -     @339 
# KERNEL:     data  integral  4     'h2  
# KERNEL: -------------------------------      

//compare ()
// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;

class parent extends uvm_object;
  rand bit [3:0] data;
  function new(string path="parent");
    super.new(path);
  endfunction
  
  `uvm_object_utils_begin(parent)
  `uvm_field_int(data,UVM_DEFAULT)
  `uvm_object_utils_end  
endclass

module tb;
  parent p1,p2;
  bit status;
  initial
    begin
      p1=new();
      p2=new();
      assert(p1.randomize());
      assert(p2.randomize());

      status=p2.compare(p1);
      `uvm_info("Top_tb",$sformatf("status=%0d",status),UVM_NONE);
    end

endmodule
//output
# KERNEL: UVM_INFO /home/build/vlib1/vlib/uvm-1.2/src/base/uvm_comparer.svh(351) @ 0: reporter [MISCMP] Miscompare for parent.data: lhs = 'h2 : rhs = 'h6
# KERNEL: UVM_INFO /home/build/vlib1/vlib/uvm-1.2/src/base/uvm_comparer.svh(382) @ 0: reporter [MISCMP] 1 Miscompare(s) for object parent@335 vs. parent@336
# KERNEL: UVM_INFO /home/runner/testbench.sv(28) @ 0: reporter [Top_tb] status=0


//same compare code by copying one handle to another handle for getting same data in both handles for status=1
// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;

class parent extends uvm_object;
  rand bit [3:0] data;
  function new(string path="parent");
    super.new(path);
  endfunction
  
  `uvm_object_utils_begin(parent)
  `uvm_field_int(data,UVM_DEFAULT)
  `uvm_object_utils_end  
endclass

module tb;
  parent p1,p2;
  bit status;
  initial
    begin
      p1=new();
      p2=new();
      assert(p1.randomize());
      assert(p2.randomize());
      p2.copy(p1);
      status=p2.compare(p1);
      `uvm_info("Top_tb",$sformatf("status=%0d",status),UVM_NONE);
    end

endmodule

//output
# KERNEL: UVM_INFO /home/runner/testbench.sv(28) @ 0: reporter [Top_tb] status=1



//same code
// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;

class parent extends uvm_object;
  rand bit [3:0] data;
  function new(string path="parent");
    super.new(path);
  endfunction
  
  `uvm_object_utils_begin(parent)
  `uvm_field_int(data,UVM_DEFAULT)
  `uvm_object_utils_end  
endclass

module tb;
  parent p1,p2;
  bit status;
  initial
    begin
      p1=new();
      p2=new();
      assert(p1.randomize());
      assert(p2.randomize());
      p2.copy(p1);
      status=p2.compare(p1);
      if(status)
        $display("compared");
      else
        $display("Not Compared");
      `uvm_info("Top_tb",$sformatf("status=%0d",status),UVM_NONE);
    end
endmodule

//output
# KERNEL: compared
# KERNEL: UVM_INFO /home/runner/testbench.sv(32) @ 0: reporter [Top_tb] status=1

//create() field macro
// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;

class parent extends uvm_object;
  rand bit [3:0] data;
  function new(string path="parent");
    super.new(path);
  endfunction
  
  `uvm_object_utils_begin(parent)
  `uvm_field_int(data,UVM_DEFAULT)
  `uvm_object_utils_end  
endclass

module tb;
  parent p1,p2;
  bit status;
  initial
    begin
    //  p1=new();
      //p2=new();
      p1=parent::type_id::create("p1");
      p2=parent::type_id::create("p2");
      assert(p1.randomize());
      assert(p2.randomize());
      p1.print();
      p2.print();
      
    end
endmodule
//output
 # KERNEL: -----------------------------
# KERNEL: Name    Type      Size  Value
# KERNEL: -----------------------------
# KERNEL: p1      parent    -     @335 
# KERNEL:   data  integral  4     'h6  
# KERNEL: -----------------------------
# KERNEL: -----------------------------
# KERNEL: Name    Type      Size  Value
# KERNEL: -----------------------------
# KERNEL: p2      parent    -     @336 
# KERNEL:   data  integral  4     'h2  
# KERNEL: -----------------------------



// Code your testbench here
// or browse Examples

`include "uvm_macros.svh"
import uvm_pkg::*;

class y extends uvm_component;
  `uvm_component_utils(y)
  
  function new(string path="y", uvm_component parent);
    super.new(path,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("y","Build phase excuted",UVM_NONE);
  endfunction
endclass


class z extends uvm_component;
  `uvm_component_utils(z)
  
  function new(string path="z", uvm_component parent);
    super.new(path,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("z","Build phase excuted",UVM_NONE);
  endfunction
endclass



class x extends uvm_component;
  `uvm_component_utils(x)
  y y_inst;
  z z_inst;
  
  function new(string path="x", uvm_component parent);
    super.new(path,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    y_inst=y::type_id::create("y_inst",this);
    z_inst=z::type_id::create("z_inst",this);
  endfunction
endclass

module tb;
  initial
    begin
      run_test("x");
    end
endmodule

//output
# KERNEL: UVM_INFO @ 0: reporter [RNTST] Running test x...
# KERNEL: UVM_INFO /home/runner/testbench.sv(16) @ 0: uvm_test_top.y_inst [y] Build phase excuted
# KERNEL: UVM_INFO /home/runner/testbench.sv(30) @ 0: uvm_test_top.z_inst [z] Build phase excuted
# KERNEL: UVM_INFO /home/build/vlib1/vlib/uvm-1.2/src/base/uvm_report_server.svh(869) @ 0: reporter [UVM/REPORT/SERVER] 













     
             


             





















