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

//same code without run test
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
    y_inst.build_phase(null);
    z_inst.build_phase(null);

  endfunction
endclass

module tb;
  x x1;
  initial
    begin
       x1=x::type_id::create("x1",null);
      x1.build_phase(null);
      //run_test("x");
    end
endmodule
//output
# KERNEL: UVM_WARNING @ 0: x1 [UVM_DEPRECATED] build()/build_phase() has been called explicitly, outside of the phasing system. This usage of build is deprecated and may lead to unexpected behavior.
# KERNEL: UVM_WARNING @ 0: x1.y_inst [UVM_DEPRECATED] build()/build_phase() has been called explicitly, outside of the phasing system. This usage of build is deprecated and may lead to unexpected behavior.
# KERNEL: UVM_INFO /home/runner/testbench.sv(13) @ 0: x1.y_inst [y] Build phase excuted
# KERNEL: UVM_WARNING @ 0: x1.z_inst [UVM_DEPRECATED] build()/build_phase() has been called explicitly, outside of the phasing system. This usage of build is deprecated and may lead to unexpected behavior.
# KERNEL: UVM_INFO /home/runner/testbench.sv(27) @ 0: x1.z_inst [z] Build phase excuted


//config db code from test to env
`include "uvm_macros.svh"
import uvm_pkg::*;

class env extends uvm_component;
  `uvm_component_utils(env)
  int data;
  
  function new(string name="env", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (uvm_config_db#(int)::get(this, "", "data", data))
      $display("DATA = %0d", data);
      else
        `uvm_error("ENV", "data not accessed")
  endfunction
endclass


class test extends uvm_test;
  `uvm_component_utils(test)
  env e;
  function new(string name="test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("e", this);
    uvm_config_db#(int)::set(this, "e", "data", 17);
  endfunction
endclass


module tb;
  initial begin
    run_test("test");
  end
endmodule

//31-12-2025
//code for two componets are instatined in agent , agent is instatined in env and config db is used for passing data from test to comp1 and comp2 through agent and env
//env -> agent -> c1 and c2
`include "uvm_macros.svh"
import uvm_pkg::*;

class comp1 extends uvm_component;
  `uvm_component_utils(comp1)
  int data;

  function new(string name="comp1", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (uvm_config_db#(int)::get(this, "", "data", data))
      $display("COMP1 DATA = %0d", data);
    else
      `uvm_error("COMP1", "data not accessed")
  endfunction
endclass


class comp2 extends uvm_component;
  `uvm_component_utils(comp2)
  int data;

  function new(string name="comp2", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (uvm_config_db#(int)::get(this, "", "data", data))
      $display("COMP2 DATA = %0d", data);
    else
      `uvm_error("COMP2", "data not accessed")
  endfunction
endclass

class agent extends uvm_agent;
  `uvm_component_utils(agent)

  comp1 c1;
  comp2 c2;

  function new(string name="agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    c1 = comp1::type_id::create("c1", this);
    c2 = comp2::type_id::create("c2", this);
  endfunction
endclass

    
class env extends uvm_component;
  `uvm_component_utils(env)

  agent ag;

  function new(string name="env", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ag = agent::type_id::create("ag", this);
  endfunction
endclass

    
class test extends uvm_test;
  `uvm_component_utils(test)

  env e;

  function new(string name="test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("e", this);
    uvm_config_db#(int)::set(this, "e.ag.c1", "data", 17);
    uvm_config_db#(int)::set(this, "e.ag.c2", "data", 25);
  endfunction
endclass

module tb;
  initial begin
    run_test("test");
  end
endmodule
    
//output
# KERNEL: COMP1 DATA = 17
# KERNEL: COMP2 DATA = 25

//16/02/2026  after CRT and mid 1 exams 
// code with test->env->agent-> comp1 and comp2 
//with build and run phase
`include "uvm_macros.svh"
import uvm_pkg::*;

//component 1
class comp1 extends uvm_component;
  `uvm_component_utils(comp1)
  int data1;
   //constructor
  function new(string name="comp1", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(int)::get(this,"","data",data1))
      `uvm_error("COMP1","Unable to get data")
  endfunction
  //run phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("COMP1",$sformatf("Data in comp1 = %0d",data1),UVM_NONE);
    phase.drop_objection(this);
  endtask
endclass

//component 2
class comp2 extends uvm_component;
  `uvm_component_utils(comp2)
  int data2;
  //constrctor
  function new(string name="comp2", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(int)::get(this,"","data",data2))
      `uvm_error("COMP2","Unable to get data")
  endfunction
 //run phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("COMP2",$sformatf("Data in comp2 = %0d",data2),UVM_NONE);
    phase.drop_objection(this);
  endtask
endclass

//agent
class agent extends uvm_agent;
  `uvm_component_utils(agent)
 //componets instation under agent
  comp1 c1;
  comp2 c2;
  //construcor
  function new(string name="agent", uvm_component parent=null);
    super.new(name,parent);
  endfunction
 //build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    c1 = comp1::type_id::create("c1",this);
    c2 = comp2::type_id::create("c2",this);
  endfunction
endclass

//enivornment
class env extends uvm_env;
  `uvm_component_utils(env)
 //agent instatied in env
  agent ag;
 //constructor
  function new(string name="env", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ag = agent::type_id::create("ag",this);
  endfunction
endclass

//test
class test extends uvm_test;
  `uvm_component_utils(test)

  env e;

  function new(string name="test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("e",this);
  endfunction
endclass


module tb;

  int data=256;

  initial begin
    uvm_config_db#(int)::set(null,"*","data",data);
    run_test("test");
  end

endmodule

//output for above code
# KERNEL: UVM_INFO /home/runner/testbench.sv(43) @ 0: uvm_test_top.e.ag.c2 [COMP2] Data in comp2 = 256
# KERNEL: UVM_INFO /home/runner/testbench.sv(21) @ 0: uvm_test_top.e.ag.c1 [COMP1] Data in comp1 = 256
# KERNEL: UVM_INFO ./uvm-1.2/src/base/uvm_objection.svh(1271) @ 0: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase
# KERNEL: UVM_INFO ./uvm-1.2/src/base/uvm_report_server.svh(869) @ 0: reporter [UVM/REPORT/SERVER]


//same code with diffrent data for comp1 and comp2
`include "uvm_macros.svh"
import uvm_pkg::*;

//component 1
class comp1 extends uvm_component;
  `uvm_component_utils(comp1)
  int data1;
   //constructor
  function new(string name="comp1", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(int)::get(this,"","data",data1))
      `uvm_error("COMP1","Unable to get data")
  endfunction
  //run phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("COMP1",$sformatf("Data in comp1 = %0d",data1),UVM_NONE);
    phase.drop_objection(this);
  endtask
endclass

//component 2
class comp2 extends uvm_component;
  `uvm_component_utils(comp2)
  int data2;
  //constrctor
  function new(string name="comp2", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(int)::get(this,"","data",data2))
      `uvm_error("CMP2","Unable to get data")
  endfunction
 //run phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("COMP2",$sformatf("Data in comp2 = %0d",data2),UVM_NONE);
    phase.drop_objection(this);
  endtask
endclass

//agent
class agent extends uvm_agent;
  `uvm_component_utils(agent)
 //componets instation under agent
  comp1 c1;
  comp2 c2;
  //construcor
  function new(string name="agent", uvm_component parent=null);
    super.new(name,parent);
  endfunction
 //build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    c1 = comp1::type_id::create("c1",this);
    c2 = comp2::type_id::create("c2",this);
  endfunction
endclass

//enivornment
class env extends uvm_env;
  `uvm_component_utils(env)
 //agent instatied in env
  agent ag;
 //constructor
  function new(string name="env", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  //build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ag = agent::type_id::create("ag",this);
  endfunction
endclass

//test
class test extends uvm_test;
  `uvm_component_utils(test)

  env e;

  function new(string name="test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("e",this);
    uvm_config_db#(int)::set(this, "e.ag.c1", "data", 17);
    uvm_config_db#(int)::set(this, "e.ag.c2", "data", 25);
  endfunction
endclass


module tb;
  initial begin
    run_test("test");
  end
endmodule

//output for above code
L: UVM_INFO @ 0: reporter [RNTST] Running test test...
# KERNEL: UVM_INFO /home/runner/testbench.sv(43) @ 0: uvm_test_top.e.ag.c2 [COMP2] Data in comp2 = 25
# KERNEL: UVM_INFO /home/runner/testbench.sv(21) @ 0: uvm_test_top.e.ag.c1 [COMP1] Data in comp1 = 17
# KERNEL: UVM_INFO ./uvm-1.2/src/base/uvm_objection.svh(1271) @ 0: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase

//TLM port communication using put_port , put_export and put_imp
//where the memory for all tlm ports are created in custom constrcur it self not in build phase

`include "uvm_macros.svh"
import uvm_pkg::*;

class producer extends uvm_component;
  `uvm_component_utils(producer);
   int data=10; 
  
  uvm_blocking_put_port#(int) send;
  
  function new(string path="producer", uvm_component parent=null);
    super.new(path,parent);
    send=new("send",this);
  endfunction
  
  task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    send.put(data);
    `uvm_info("send",$sformatf("data sent=%0d",data),UVM_NONE);
    phase.drop_objection(this);
  endtask
endclass

class consumer extends uvm_component;
  `uvm_component_utils(consumer);
  uvm_blocking_put_export#(int)rec;
  uvm_blocking_put_imp#(int, consumer) imp;
  function new(string path="consumer", uvm_component parent=null);
    super.new(path,parent);
    rec=new("rec",this);
    imp=new("imp",this);
  endfunction
  task put(int rdata);
    `uvm_info("CONSUMER",$sformatf("data recived=%0d",rdata),UVM_NONE);
  endtask
             
endclass

class env extends uvm_env;
  `uvm_component_utils(env);
  producer p;
  consumer c;
  
  function new(string path="env", uvm_component parent=null);
    super.new(path,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    p=producer::type_id::create("p",this);
    c=consumer::type_id::create("c",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    p.send.connect(c.rec);
    c.rec.connect(c.imp);
  endfunction
  
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test);
  env e;
  function new(string path="test", uvm_component parent=null);
    super.new(path,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e=env::type_id::create("e",this);
  endfunction
endclass

module top;
  initial
    begin
      run_test("test");
    end
endmodule

//output
# KERNEL: UVM_INFO /home/runner/testbench.sv(34) @ 0: uvm_test_top.e.c [CONSUMER] data recived=10
# KERNEL: UVM_INFO /home/runner/testbench.sv(19) @ 0: uvm_test_top.e.p [send] data sent=10

//why consumer is printing first than producer because , data is priniintg in task , and run phase is bottom up approach


//same code with separate memory allocation for put_port and put_imp in producer and consumer and implemantion in build phase
`include "uvm_macros.svh"
import uvm_pkg::*;

//class producer
class producer extends uvm_component;
  `uvm_component_utils(producer);
   int data=10; 
  //put_port
  uvm_blocking_put_port#(int) send;
  //constructor
  function new(string path="producer", uvm_component parent=null);
    super.new(path,parent);
  endfunction
  //build phase for memory for put port
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    send=new("send",this);
  endfunction
  //sub phase of run task for sending data 
  task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    send.put(data);
    `uvm_info("send",$sformatf("data sent=%0d",data),UVM_NONE);
    phase.drop_objection(this);
  endtask
endclass

//class consumer
class consumer extends uvm_component;
  `uvm_component_utils(consumer);
  //put export class
  uvm_blocking_put_export#(int)rec;
  //put implemantion class
  uvm_blocking_put_imp#(int, consumer) imp;
  //construtor
  function new(string path="consumer", uvm_component parent=null);
    super.new(path,parent);
  endfunction
  //build phase for export and implementation
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      rec=new("rec",this);
    imp=new("imp",this);
  endfunction
   
  //receving data task
  task put(int rdata);
    `uvm_info("CONSUMER",$sformatf("data recived=%0d",rdata),UVM_NONE);
  endtask     
endclass

//class environment
class env extends uvm_env;
  `uvm_component_utils(env);
  producer p;
  consumer c;
  //construtor
  function new(string path="env", uvm_component parent=null);
    super.new(path,parent);
  endfunction
  //build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    p=producer::type_id::create("p",this);
    c=consumer::type_id::create("c",this);
  endfunction
  //connet phase for conneting sender and consumer and implemetation
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    p.send.connect(c.rec);
    c.rec.connect(c.imp);
  endfunction
  
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test);
  env e;
  function new(string path="test", uvm_component parent=null);
    super.new(path,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e=env::type_id::create("e",this);
  endfunction
endclass

module top;
  initial
    begin
      run_test("test");
    end
endmodule

//output
# KERNEL: UVM_INFO @ 0: reporter [RNTST] Running test test...
# KERNEL: UVM_INFO /home/runner/testbench.sv(43) @ 0: uvm_test_top.e.c [CONSUMER] data recived=10
# KERNEL: UVM_INFO /home/runner/testbench.sv(23) @ 0: uvm_test_top.e.p [send] data sent=10


//same code with only producer and implemantion without consumer , port is directly conneted to implementation
`include "uvm_macros.svh"
import uvm_pkg::*;

//class producer
class producer extends uvm_component;
  `uvm_component_utils(producer);
   int data=10; 
  //put_port
  uvm_blocking_put_port#(int) send;
  //constructor
  function new(string path="producer", uvm_component parent=null);
    super.new(path,parent);
  endfunction
  //build phase for memory for put port
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    send=new("send",this);
  endfunction
  //sub phase of run task for sending data 
  task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    send.put(data);
    `uvm_info("send",$sformatf("data sent=%0d",data),UVM_NONE);
    phase.drop_objection(this);
  endtask
endclass

//class consumer
class consumer extends uvm_component;
  `uvm_component_utils(consumer);
  //put export class
  //uvm_blocking_put_export#(int)rec;
  //put implemantion class
  uvm_blocking_put_imp#(int, consumer) imp;
  //construtor
  function new(string path="consumer", uvm_component parent=null);
    super.new(path,parent);
  endfunction
  //build phase for export and implementation
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //  rec=new("rec",this);
    imp=new("imp",this);
  endfunction
   
  //receving data task
  task put(int rdata);
    `uvm_info("CONSUMER",$sformatf("data recived=%0d",rdata),UVM_NONE);
  endtask     
endclass

//class environment
class env extends uvm_env;
  `uvm_component_utils(env);
  producer p;
  consumer c;
  //construtor
  function new(string path="env", uvm_component parent=null);
    super.new(path,parent);
  endfunction
  //build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    p=producer::type_id::create("p",this);
    c=consumer::type_id::create("c",this);
  endfunction
  //connet phase for conneting sender and consumer and implemetation
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    p.send.connect(c.imp);
   // c.rec.connect(c.imp);
  endfunction
  
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test);
  env e;
  function new(string path="test", uvm_component parent=null);
    super.new(path,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e=env::type_id::create("e",this);
  endfunction
endclass

module top;
  initial
    begin
      run_test("test");
    end
endmodule

//output
# KERNEL: UVM_INFO @ 0: reporter [RNTST] Running test test...
# KERNEL: UVM_INFO /home/runner/testbench.sv(48) @ 0: uvm_test_top.e.c [CONSUMER] data recived=10
# KERNEL: UVM_INFO /home/runner/testbench.sv(23) @ 0: uvm_test_top.e.p [send] data sent=10
# KERNEL: UVM_INFO ./uvm-1.2/src/base/uvm_report_server.svh(869) @ 0: reporter [UVM/REPORT/SERVER] 


//code for get operations
`include "uvm_macros.svh"
import uvm_pkg::*;

//producer class
class producer extends uvm_component;
  `uvm_component_utils(producer)
  
  // get_port --> getting data from consumer 
  uvm_blocking_get_port #(int) port;
  
  int data = 0;
  
  //constructor
  function new(input string path = "producer", uvm_component parent = null);
    super.new(path, parent);
  endfunction
  
  //build_phase for get_port
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    port   = new("port", this);
  endfunction
  
  //task main_phase for getting data from consumer using get method
  task main_phase(uvm_phase phase);
  phase.raise_objection(this);
  port.get(data);
  `uvm_info("PROD", $sformatf("Data Recv : %0d", data), UVM_NONE); 
  phase.drop_objection(this);
 endtask   
endclass
 
//consumer class
class consumer extends uvm_component;
  `uvm_component_utils(consumer)
  
  //this data will put into the producer
  int data = 12;
  
  //get_implementation
  uvm_blocking_get_imp#(int, consumer) imp;
  
  //constructor for consumer
  function new(input string path = "consumer", uvm_component parent = null);
    super.new(path, parent);
  endfunction
  
  //memory for get_imp in build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    imp  = new("imp", this);
  endfunction
  
  //virtual is used to override , here we are using get 
  //why output is declared why because consumer sends data to producer
  virtual task get(output int datar);
    `uvm_info("CONS", $sformatf("Data Sent : %0d", data), UVM_NONE); 
     datar = data;
  endtask
endclass
 
class env extends uvm_env;
`uvm_component_utils(env)
 
producer p;
consumer c;
 
 
  function new(input string path = "env", uvm_component parent = null);
    super.new(path, parent);
endfunction

  //build phase
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  c = consumer::type_id::create("c", this);
  p = producer::type_id::create("p",this);
endfunction
 
 //conncet phase 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
  p.port.connect(c.imp);
endfunction
 endclass
 
 
class test extends uvm_test;
`uvm_component_utils(test)
 
env e;
 
function new(input string path = "test", uvm_component parent = null);
  super.new(path, parent);
endfunction
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  e = env::type_id::create("e",this);
endfunction 
endclass

module tb;
initial begin
  run_test("test");
end
 
 
endmodule

//output
# KERNEL: UVM_INFO @ 0: reporter [RNTST] Running test test...
# KERNEL: UVM_INFO /home/runner/testbench.sv(46) @ 0: uvm_test_top.e.c [CONS] Data Sent : 12
# KERNEL: UVM_INFO /home/runner/testbench.sv(23) @ 0: uvm_test_top.e.p [PROD] Data Recv : 12


//transport operation
`include "uvm_macros.svh"
import uvm_pkg::*;
 
class producer extends uvm_component;
  `uvm_component_utils(producer)
  
  uvm_blocking_transport_port #(int , int) port;
  
  int datas = 12;
  int datar = 0;
  
  function new(input string path = "producer", uvm_component parent = null);
    super.new(path, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    port   = new("port", this);
  endfunction
  
  task main_phase(uvm_phase phase);
  phase.raise_objection(this);
  
   port.transport(datas, datar);
    
  `uvm_info("PROD", $sformatf("Data Sent : %0d , Data Recv : %0d", datas, datar), UVM_NONE); 
  
  phase.drop_objection(this);
 endtask
  
  
endclass
 
class consumer extends uvm_component;
  `uvm_component_utils(consumer)
  
  int datas = 13;
  int datar = 0;
  
  uvm_blocking_transport_imp#(int, int , consumer) imp;
  
  function new(input string path = "consumer", uvm_component parent = null);
    super.new(path, parent);
  endfunction
  
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    imp  = new("imp", this);
  endfunction
  
  virtual task transport(input int datar , output int datas);
    datas = this.datas;
    `uvm_info("CONS", $sformatf("Data Sent : %0d , Data Recv : %0d", datas, datar), UVM_NONE); 
  endtask
endclass

 
class env extends uvm_env;
`uvm_component_utils(env)
 
producer p;
consumer c;
 
 
  function new(input string path = "env", uvm_component parent = null);
    super.new(path, parent);
endfunction
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  c = consumer::type_id::create("c", this);
  p = producer::type_id::create("p",this);
endfunction
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
  p.port.connect(c.imp);
endfunction
endclass
 
 
class test extends uvm_test;
`uvm_component_utils(test)
 
env e;
 
function new(input string path = "test", uvm_component parent = null);
  super.new(path, parent);
endfunction
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  e = env::type_id::create("e",this);
endfunction
 
 
endclass
 

module tb; 
initial begin
  run_test("test");
end 
endmodule

//output
# KERNEL: UVM_INFO @ 0: reporter [RNTST] Running test test...
# KERNEL: UVM_INFO /home/runner/testbench.sv(54) @ 0: uvm_test_top.e.c [CONS] Data Sent : 13 , Data Recv : 12
# KERNEL: UVM_INFO /home/runner/testbench.sv(26) @ 0: uvm_test_top.e.p [PROD] Data Sent : 12 , Data Recv : 13

//analysis port 
`include "uvm_macros.svh"
import uvm_pkg::*;

class producer extends uvm_component;
  `uvm_component_utils(producer)

  uvm_analysis_port #(int) port;

  int data = 12;

  function new(input string path = "producer", uvm_component parent = null);
    super.new(path, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    port   = new("port", this);
  endfunction

  task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("PROD", $sformatf("Data Broadcasted : %0d", data), UVM_NONE);
    port.write(data);
    phase.drop_objection(this);
  endtask  
endclass

class consumer1 extends uvm_component;
  `uvm_component_utils(consumer1)


  uvm_analysis_imp#(int, consumer1) imp;

  function new(input string path = "consumer1", uvm_component parent = null);
    super.new(path, parent);
  endfunction


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    imp  = new("imp", this);
  endfunction

  virtual function void write(int datar);
    `uvm_info("CONS1", $sformatf("Data Recv : %0d", datar), UVM_NONE); 
  endfunction
endclass


class consumer2 extends uvm_component;
  `uvm_component_utils(consumer2)


  uvm_analysis_imp#(int, consumer2) imp;

  function new(input string path = "consumer2", uvm_component parent = null);
    super.new(path, parent);
  endfunction


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    imp  = new("imp", this);
  endfunction

  virtual function void write(int datar);
    `uvm_info("CONS2", $sformatf("Data Recv : %0d", datar), UVM_NONE); 
  endfunction
endclass  


class env extends uvm_env;
  `uvm_component_utils(env)

  producer p;
  consumer1 c1;
  consumer2 c2;  


  function new(input string path = "env", uvm_component parent = null);
    super.new(path, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    c1 = consumer1::type_id::create("c1", this);
    c2 = consumer2::type_id::create("c2", this);
    p = producer::type_id::create("p",this);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    p.port.connect(c1.imp);
    p.port.connect(c2.imp);
  endfunction 
endclass


class test extends uvm_test;
  `uvm_component_utils(test)

  env e;

  function new(input string path = "test", uvm_component parent = null);
    super.new(path, parent);
  endfunction


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("e",this);
  endfunction 
endclass

module tb;
  initial begin
    run_test("test");
  end
endmodule
//output
# KERNEL: UVM_INFO /home/runner/testbench.sv(22) @ 0: uvm_test_top.e.p [PROD] Data Broadcasted : 12
# KERNEL: UVM_INFO /home/runner/testbench.sv(45) @ 0: uvm_test_top.e.c1 [CONS1] Data Recv : 12
# KERNEL: UVM_INFO /home/runner/testbench.sv(67) @ 0: uvm_test_top.e.c2 [CONS2] Data Recv : 12
# KERNEL: UVM_INFO ./uvm-1.2/src/base/uvm_report_server.svh(869) @ 0: reporter [UVM/REPORT/SERVER] 



//uvm complete tb for adder code 

//design code
module add(
input [3:0] a,b,
output [4:0] y);
assign y = a + b;    
endmodule

//interface
interface add_if();
logic [3:0] a;
logic [3:0] b;
logic [4:0] y;
endinterface


//tb
`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

//transaction class from the uvm_sequence_item 
class transaction extends uvm_sequence_item;
rand bit [3:0] a;
rand bit [3:0] b;
bit [4:0] y;
 
 //construcor
  function new(input string path = "transaction");
    super.new(path);
  endfunction
//factory registration using field macros
`uvm_object_utils_begin(transaction)
`uvm_field_int(a, UVM_DEFAULT)
`uvm_field_int(b, UVM_DEFAULT)
`uvm_field_int(y, UVM_DEFAULT)
`uvm_object_utils_end
 endclass

//class generator from uvm_sequence
class generator extends uvm_sequence #(transaction);
`uvm_object_utils(generator)
 
transaction t;
integer i;
 
  function new(input string path = "generator");
    super.new(path);
  endfunction
 
 
virtual task body();
  t = transaction::type_id::create("t");
  repeat(10) 
    begin
    start_item(t);
    t.randomize();
    `uvm_info("GEN",$sformatf("Data send to Driver a :%0d , b :%0d",t.a,t.b), UVM_NONE);
    finish_item(t);
    end
endtask
endclass

class driver extends uvm_driver #(transaction);
`uvm_component_utils(driver)
 
    function new(input string path = "driver", uvm_component parent = null);
      super.new(path, parent);
     endfunction
 
transaction tc;
  
virtual add_if aif;
 
    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      tc = transaction::type_id::create("tc");
 
      if(!uvm_config_db #(virtual add_if)::get(this,"","aif",aif)) 
      `uvm_error("DRV","Unable to access uvm_config_db");
    endfunction
 
    virtual task run_phase(uvm_phase phase);
    forever begin
      
    seq_item_port.get_next_item(tc);
    aif.a <= tc.a;
    aif.b <= tc.b;
      `uvm_info("DRV", $sformatf("Trigger DUT a: %0d ,b :  %0d",tc.a, tc.b), UVM_NONE); 
    seq_item_port.item_done();
    #10;  
      
    end
    endtask
endclass


class monitor extends uvm_monitor;
`uvm_component_utils(monitor)
 
uvm_analysis_port #(transaction) send;
 
  function new(input string path = "monitor", uvm_component parent = null);
    super.new(path, parent);
    send = new("send", this);
  endfunction
 
  transaction t;
  virtual add_if aif;
 
  virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
    t = transaction::type_id::create("t");
    
   if(!uvm_config_db #(virtual add_if)::get(this,"","aif",aif)) 
   `uvm_error("MON","Unable to access uvm_config_db");
  endfunction
 
    virtual task run_phase(uvm_phase phase);
    forever begin
    #10;
    t.a = aif.a;
    t.b = aif.b;
    t.y = aif.y;
    `uvm_info("MON", $sformatf("Data send to Scoreboard a : %0d , b : %0d and y : %0d", t.a,t.b,t.y), UVM_NONE);
    send.write(t);
    end
    endtask
endclass

class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
 
uvm_analysis_imp #(transaction,scoreboard) recv;
 
transaction tr;
 
  function new(input string path = "scoreboard", uvm_component parent = null);
    super.new(path, parent);
    recv = new("recv", this);
  endfunction
 
  virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    tr = transaction::type_id::create("tr");
  endfunction
 
  virtual function void write(input transaction t);
   tr = t;
  `uvm_info("SCO",$sformatf("Data rcvd from Monitor a: %0d , b : %0d and y : %0d",tr.a,tr.b,tr.y), UVM_NONE);
  
    if(tr.y == tr.a + tr.b)
       `uvm_info("SCO","Test Passed", UVM_NONE)
   else
       `uvm_info("SCO","Test Failed", UVM_NONE);
   endfunction
endclass

class agent extends uvm_agent;
`uvm_component_utils(agent)
 
function new(input string inst = "AGENT", uvm_component c);
super.new(inst, c);
endfunction
 
monitor m;
driver d;
uvm_sequencer #(transaction) seqr;
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  m = monitor::type_id::create("m",this);
  d = driver::type_id::create("d",this);
  seqr = uvm_sequencer #(transaction)::type_id::create("seqr",this);
endfunction
 
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
  d.seq_item_port.connect(seqr.seq_item_export);
endfunction
endclass

class env extends uvm_env;
`uvm_component_utils(env)
 
 
function new(input string inst = "ENV", uvm_component c);
super.new(inst, c);
endfunction
 
scoreboard s;
agent a;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  s = scoreboard::type_id::create("s",this);
  a = agent::type_id::create("a",this);
endfunction
 
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
a.m.send.connect(s.recv);
endfunction
 
endclass

class test extends uvm_test;
`uvm_component_utils(test)
 
 
function new(input string inst = "TEST", uvm_component c);
super.new(inst, c);
endfunction
 
generator gen;
env e;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  gen = generator::type_id::create("gen");
  e = env::type_id::create("e",this);
endfunction
 
virtual task run_phase(uvm_phase phase);
   phase.raise_objection(this);
   gen.start(e.a.seqr);
   #50;
   phase.drop_objection(this);
endtask
endclass

module add_tb();
 
add_if aif();
 
add dut (.a(aif.a), .b(aif.b), .y(aif.y));
 
initial begin
$dumpfile("dump.vcd");
$dumpvars;
end
  
initial begin  
uvm_config_db #(virtual add_if)::set(null, "uvm_test_top.e.a*", "aif", aif);
run_test("test");
end
 endmodule

 //output
 # KERNEL: UVM_INFO @ 0: reporter [RNTST] Running test test...
# KERNEL: UVM_INFO /home/runner/testbench.sv(38) @ 0: uvm_test_top.e.a.seqr@@gen [GEN] Data send to Driver a :10 , b :6
# KERNEL: UVM_INFO /home/runner/testbench.sv(69) @ 0: uvm_test_top.e.a.d [DRV] Trigger DUT a: 10 ,b :  6
# KERNEL: UVM_INFO /home/runner/testbench.sv(105) @ 10000: uvm_test_top.e.a.m [MON] Data send to Scoreboard a : 10 , b : 6 and y : 16
# KERNEL: UVM_INFO /home/runner/testbench.sv(130) @ 10000: uvm_test_top.e.s [SCO] Data rcvd from Monitor a: 10 , b : 6 and y : 16
# KERNEL: UVM_INFO /home/runner/testbench.sv(133) @ 10000: uvm_test_top.e.s [SCO] Test Passed
# KERNEL: UVM_INFO /home/runner/testbench.sv(38) @ 10000: uvm_test_top.e.a.seqr@@gen [GEN] Data send to Driver a :7 , b :15
# KERNEL: UVM_INFO /home/runner/testbench.sv(69) @ 10000: uvm_test_top.e.a.d [DRV] Trigger DUT a: 7 ,b :  15
# KERNEL: UVM_INFO /home/runner/testbench.sv(105) @ 20000: uvm_test_top.e.a.m [MON] Data send to Scoreboard a : 7 , b : 15 and y : 22
# KERNEL: UVM_INFO /home/runner/testbench.sv(130) @ 20000: uvm_test_top.e.s [SCO] Data rcvd from Monitor a: 7 , b : 15 and y : 22
# KERNEL: UVM_INFO /home/runner/testbench.sv(133) @ 20000: uvm_test_top.e.s [SCO] Test Passed
# KERNEL: UVM_INFO /home/runner/testbench.sv(38) @ 20000: uvm_test_top.e.a.seqr@@gen [GEN] Data send to Driver a :1 , b :1
# KERNEL: UVM_INFO /home/runner/testbench.sv(69) @ 20000: uvm_test_top.e.a.d [DRV] Trigger DUT a: 1 ,b :  1
# KERNEL: UVM_INFO /home/runner/testbench.sv(105) @ 30000: uvm_test_top.e.a.m [MON] Data send to Scoreboard a : 1 , b : 1 and y : 2
# KERNEL: UVM_INFO /home/runner/testbench.sv(130) @ 30000: uvm_test_top.e.s [SCO] Data rcvd from Monitor a: 1 , b : 1 and y : 2
# KERNEL: UVM_INFO /home/runner/testbench.sv(133) @ 30000: uvm_test_top.e.s [SCO] Test Passed
# KERNEL: UVM_INFO /home/runner/testbench.sv(38) @ 30000: uvm_test_top.e.a.seqr@@gen [GEN] Data send to Driver a :8 , b :12
# KERNEL: UVM_INFO /home/runner/testbench.sv(69) @ 30000: uvm_test_top.e.a.d [DRV] Trigger DUT a: 8 ,b :  12
# KERNEL: UVM_INFO /home/runner/testbench.sv(105) @ 40000: uvm_test_top.e.a.m [MON] Data send to Scoreboard a : 8 , b : 12 and y : 20
# KERNEL: UVM_INFO /home/runner/testbench.sv(130) @ 40000: uvm_test_top.e.s [SCO] Data rcvd from Monitor a: 8 , b : 12 and y : 20
# KERNEL: UVM_INFO /home/runner/testbench.sv(133) @ 40000: uvm_test_top.e.s [SCO] Test Passed
# KERNEL: UVM_INFO /home/runner/testbench.sv(38) @ 40000: uvm_test_top.e.a.seqr@@gen [GEN] Data send to Driver a :12 , b :0
# KERNEL: UVM_INFO /home/runner/testbench.sv(69) @ 40000: uvm_test_top.e.a.d [DRV] Trigger DUT a: 12 ,b :  0
# KERNEL: UVM_INFO /home/runner/testbench.sv(105) @ 50000: uvm_test_top.e.a.m [MON] Data send to Scoreboard a : 12 , b : 0 and y : 12
# KERNEL: UVM_INFO /home/runner/testbench.sv(130) @ 50000: uvm_test_top.e.s [SCO] Data rcvd from Monitor a: 12 , b : 0 and y : 12
# KERNEL: UVM_INFO /home/runner/testbench.sv(133) @ 50000: uvm_test_top.e.s [SCO] Test Passed
# KERNEL: UVM_INFO /home/runner/testbench.sv(38) @ 50000: uvm_test_top.e.a.seqr@@gen [GEN] Data send to Driver a :13 , b :13
# KERNEL: UVM_INFO /home/runner/testbench.sv(69) @ 50000: uvm_test_top.e.a.d [DRV] Trigger DUT a: 13 ,b :  13
# KERNEL: UVM_INFO /home/runner/testbench.sv(105) @ 60000: uvm_test_top.e.a.m [MON] Data send to Scoreboard a : 13 , b : 13 and y : 26
# KERNEL: UVM_INFO /home/runner/testbench.sv(130) @ 60000: uvm_test_top.e.s [SCO] Data rcvd from Monitor a: 13 , b : 13 and y : 26
# KERNEL: UVM_INFO /home/runner/testbench.sv(133) @ 60000: uvm_test_top.e.s [SCO] Test Passed
# KERNEL: UVM_INFO /home/runner/testbench.sv(38) @ 60000: uvm_test_top.e.a.seqr@@gen [GEN] Data send to Driver a :11 , b :3
# KERNEL: UVM_INFO /home/runner/testbench.sv(69) @ 60000: uvm_test_top.e.a.d [DRV] Trigger DUT a: 11 ,b :  3
# KERNEL: UVM_INFO /home/runner/testbench.sv(105) @ 70000: uvm_test_top.e.a.m [MON] Data send to Scoreboard a : 11 , b : 3 and y : 14
# KERNEL: UVM_INFO /home/runner/testbench.sv(130) @ 70000: uvm_test_top.e.s [SCO] Data rcvd from Monitor a: 11 , b : 3 and y : 14
# KERNEL: UVM_INFO /home/runner/testbench.sv(133) @ 70000: uvm_test_top.e.s [SCO] Test Passed
# KERNEL: UVM_INFO /home/runner/testbench.sv(38) @ 70000: uvm_test_top.e.a.seqr@@gen [GEN] Data send to Driver a :6 , b :2
# KERNEL: UVM_INFO /home/runner/testbench.sv(69) @ 70000: uvm_test_top.e.a.d [DRV] Trigger DUT a: 6 ,b :  2
# KERNEL: UVM_INFO /home/runner/testbench.sv(105) @ 80000: uvm_test_top.e.a.m [MON] Data send to Scoreboard a : 6 , b : 2 and y : 8
# KERNEL: UVM_INFO /home/runner/testbench.sv(130) @ 80000: uvm_test_top.e.s [SCO] Data rcvd from Monitor a: 6 , b : 2 and y : 8
# KERNEL: UVM_INFO /home/runner/testbench.sv(133) @ 80000: uvm_test_top.e.s [SCO] Test Passed
# KERNEL: UVM_INFO /home/runner/testbench.sv(38) @ 80000: uvm_test_top.e.a.seqr@@gen [GEN] Data send to Driver a :14 , b :10
# KERNEL: UVM_INFO /home/runner/testbench.sv(69) @ 80000: uvm_test_top.e.a.d [DRV] Trigger DUT a: 14 ,b :  10
# KERNEL: UVM_INFO /home/runner/testbench.sv(105) @ 90000: uvm_test_top.e.a.m [MON] Data send to Scoreboard a : 14 , b : 10 and y : 24
# KERNEL: UVM_INFO /home/runner/testbench.sv(130) @ 90000: uvm_test_top.e.s [SCO] Data rcvd from Monitor a: 14 , b : 10 and y : 24
# KERNEL: UVM_INFO /home/runner/testbench.sv(133) @ 90000: uvm_test_top.e.s [SCO] Test Passed
# KERNEL: UVM_INFO /home/runner/testbench.sv(38) @ 90000: uvm_test_top.e.a.seqr@@gen [GEN] Data send to Driver a :3 , b :11
# KERNEL: UVM_INFO /home/runner/testbench.sv(69) @ 90000: uvm_test_top.e.a.d [DRV] Trigger DUT a: 3 ,b :  11
# KERNEL: UVM_INFO /home/runner/testbench.sv(105) @ 100000: uvm_test_top.e.a.m [MON] Data send to Scoreboard a : 3 , b : 11 and y : 14
# KERNEL: UVM_INFO /home/runner/testbench.sv(130) @ 100000: uvm_test_top.e.s [SCO] Data rcvd from Monitor a: 3 , b : 11 and y : 14
# KERNEL: UVM_INFO /home/runner/testbench.sv(133) @ 100000: uvm_test_top.e.s [SCO] Test Passed
# KERNEL: UVM_INFO /home/runner/testbench.sv(105) @ 110000: uvm_test_top.e.a.m [MON] Data send to Scoreboard a : 3 , b : 11 and y : 14
# KERNEL: UVM_INFO /home/runner/testbench.sv(130) @ 110000: uvm_test_top.e.s [SCO] Data rcvd from Monitor a: 3 , b : 11 and y : 14
# KERNEL: UVM_INFO /home/runner/testbench.sv(133) @ 110000: uvm_test_top.e.s [SCO] Test Passed
# KERNEL: UVM_INFO /home/runner/testbench.sv(105) @ 120000: uvm_test_top.e.a.m [MON] Data send to Scoreboard a : 3 , b : 11 and y : 14
# KERNEL: UVM_INFO /home/runner/testbench.sv(130) @ 120000: uvm_test_top.e.s [SCO] Data rcvd from Monitor a: 3 , b : 11 and y : 14
# KERNEL: UVM_INFO /home/runner/testbench.sv(133) @ 120000: uvm_test_top.e.s [SCO] Test Passed
# KERNEL: UVM_INFO /home/runner/testbench.sv(105) @ 130000: uvm_test_top.e.a.m [MON] Data send to Scoreboard a : 3 , b : 11 and y : 14
# KERNEL: UVM_INFO /home/runner/testbench.sv(130) @ 130000: uvm_test_top.e.s [SCO] Data rcvd from Monitor a: 3 , b : 11 and y : 14
# KERNEL: UVM_INFO /home/runner/testbench.sv(133) @ 130000: uvm_test_top.e.s [SCO] Test Passed
# KERNEL: UVM_INFO /home/runner/testbench.sv(105) @ 140000: uvm_test_top.e.a.m [MON] Data send to Scoreboard a : 3 , b : 11 and y : 14
# KERNEL: UVM_INFO /home/runner/testbench.sv(130) @ 140000: uvm_test_top.e.s [SCO] Data rcvd from Monitor a: 3 , b : 11 and y : 14
# KERNEL: UVM_INFO /home/runner/testbench.sv(133) @ 140000: uvm_test_top.e.s [SCO] Test Passed
# KERNEL: UVM_INFO ./uvm-1.2/src/base/uvm_objection.svh(1271) @ 140000: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase


//same code with clock and reset
module add(
input clk,rst,
input [3:0] a,b,
output reg [4:0] y
    );
  
  always@(posedge clk)
    begin
      if(rst)
       y <= 5'b00000;
      else
       y <= a + b; 
    end
  
endmodule
 
////////////////////////////////////////////////////////////
interface add_if();
logic clk;
logic rst;
logic [3:0] a;
logic [3:0] b;
logic [4:0] y;
endinterface

//tb
`timescale 1ns / 1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
 
class transaction extends uvm_sequence_item;
rand bit [3:0] a;
rand bit [3:0] b;
bit [4:0] y;
 
  function new(input string inst = "transaction");
super.new(inst);
endfunction
 
`uvm_object_utils_begin(transaction)
`uvm_field_int(a, UVM_DEFAULT)
`uvm_field_int(b, UVM_DEFAULT)
`uvm_field_int(y, UVM_DEFAULT)
`uvm_object_utils_end
endclass
 

class generator extends uvm_sequence #(transaction);
`uvm_object_utils(generator)
 
transaction t;
 
 
function new(input string inst = "GEN");
super.new(inst);
endfunction
 
 
virtual task body();
  t = transaction::type_id::create("t");
  repeat(10) 
    begin
    start_item(t);
    t.randomize();
    finish_item(t);
   `uvm_info("GEN",$sformatf("Data send to Driver a :%0d , b :%0d",t.a,t.b), UVM_NONE);  
    end
endtask
endclass
 

class driver extends uvm_driver #(transaction);
`uvm_component_utils(driver)
 
function new(input string inst = " DRV", uvm_component c);
super.new(inst, c);
endfunction
 
transaction data;
virtual add_if aif;
  
  
  
  ///////////////////reset logic
  task reset_dut();
    aif.rst <= 1'b1;
    aif.a   <= 0;
    aif.b   <= 0;
    repeat(5) @(posedge aif.clk);
    aif.rst <= 1'b0; 
    `uvm_info("DRV", "Reset Done", UVM_NONE);
  endtask
 
  
  

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  data = transaction::type_id::create("data");
  
if(!uvm_config_db #(virtual add_if)::get(this,"","aif",aif)) 
`uvm_error("DRV","Unable to access uvm_config_db");
endfunction
 
  
  
   virtual task run_phase(uvm_phase phase);
    reset_dut();
    forever begin 
      seq_item_port.get_next_item(data);
    aif.a <= data.a;
    aif.b <= data.b;
    seq_item_port.item_done(); 
              `uvm_info("DRV", $sformatf("Trigger DUT a: %0d ,b :  %0d",data.a, data.b), UVM_NONE); 
    @(posedge aif.clk);
    @(posedge aif.clk);
    end
  
endtask
endclass
 

class monitor extends uvm_monitor;
`uvm_component_utils(monitor)
 
uvm_analysis_port #(transaction) send;
 
function new(input string inst = "MON", uvm_component c);
super.new(inst, c);
send = new("Write", this);
endfunction
 
transaction t;
virtual add_if aif;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
t = transaction::type_id::create("TRANS");
if(!uvm_config_db #(virtual add_if)::get(this,"","aif",aif)) 
`uvm_error("MON","Unable to access uvm_config_db");
endfunction
 
virtual task run_phase(uvm_phase phase);
  @(negedge aif.rst);
   forever begin
     repeat(2)@(posedge aif.clk);
    t.a = aif.a;
    t.b = aif.b;
    t.y = aif.y;
    `uvm_info("MON", $sformatf("Data send to Scoreboard a : %0d , b : %0d and y : %0d", t.a,t.b,t.y), UVM_NONE);
    send.write(t);
   end
endtask
endclass
 

class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
  
 
//analysis imp to receive data from monitor 
uvm_analysis_imp #(transaction,scoreboard) recv;
 
transaction data;
 
function new(input string inst = "SCO", uvm_component c);
super.new(inst, c);
recv = new("Read", this);
endfunction
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
data = transaction::type_id::create("TRANS");
endfunction
 
virtual function void write(input transaction t);
data = t;
  `uvm_info("SCO",$sformatf("Data rcvd from Monitor a: %0d , b : %0d and y : %0d",t.a,t.b,t.y), UVM_NONE);
if(data.y == data.a + data.b)
`uvm_info("SCO","Test Passed", UVM_NONE)
else
`uvm_info("SCO","Test Failed", UVM_NONE);
endfunction
endclass

 
class agent extends uvm_agent;
`uvm_component_utils(agent)
 
 
function new(input string inst = "AGENT", uvm_component c);
super.new(inst, c);
endfunction
 
monitor m;
driver d;
uvm_sequencer #(transaction) seq;
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
m = monitor::type_id::create("MON",this);
d = driver::type_id::create("DRV",this);
seq = uvm_sequencer #(transaction)::type_id::create("SEQ",this);
endfunction
 
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
d.seq_item_port.connect(seq.seq_item_export);
endfunction
endclass
 

 
class env extends uvm_env;
`uvm_component_utils(env)
 
 
function new(input string inst = "ENV", uvm_component c);
super.new(inst, c);
endfunction
 
scoreboard s;
agent a;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
s = scoreboard::type_id::create("SCO",this);
a = agent::type_id::create("AGENT",this);
endfunction
 
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
a.m.send.connect(s.recv);
endfunction
 
endclass
 

//test class 
class test extends uvm_test;
`uvm_component_utils(test)
 
 
function new(input string inst = "TEST", uvm_component c);
super.new(inst, c);
endfunction
 //HANDLE FOR GENATOR
generator gen;
env e;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
gen = generator::type_id::create("GEN",this);
e = env::type_id::create("ENV",this);
endfunction
 
virtual task run_phase(uvm_phase phase);
   phase.raise_objection(this);
   gen.start(e.a.seq);
   #60;
   phase.drop_objection(this);
 
endtask
endclass

//top module 
module add_tb();
 
add_if aif();
  
initial begin
  aif.clk = 0;
  aif.rst = 0;
end  
  //clock generation through interface
  always #10 aif.clk = ~aif.clk;
  
  
add dut (.a(aif.a), .b(aif.b), .y(aif.y), .clk(aif.clk), .rst(aif.rst));
 
initial begin
$dumpfile("dump.vcd");
$dumpvars;
end
 //setting config db 
initial begin  
uvm_config_db #(virtual add_if)::set(null, "*", "aif", aif);
//running the test
run_test("test");
end
 
endmodule

//output









































