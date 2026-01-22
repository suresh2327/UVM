# 🧪 UVM From Basics to Advanced

A structured **hands-on practice repository** for learning and mastering  
**UVM (Universal Verification Methodology)** using **SystemVerilog**.

This repository starts from **UVM fundamentals** and gradually evolves into  
**complete UVM testbench development**, including **object-oriented concepts**,  
**non-virtual methods**, and **advanced verification techniques**.

---

## 🎯 Objectives

- Build strong **UVM fundamentals**
- Understand **UVM internals and OOP behavior**
- Practice concepts using **small, focused examples**
- Develop **scalable and reusable UVM testbenches**
- Prepare for **industry-level DV projects and interviews**

---

## 🧱 Topics Covered

### 🔹 UVM Basics
- UVM reporting (`uvm_info`, `uvm_warning`, `uvm_error`)
- Verbosity levels and severity control
- Report actions (`UVM_NO_ACTION`, `UVM_EXIT`)
- Error and warning counting
- Understanding UVM output and debug flow

---

### 🔹 UVM Objects & Field Macros
- `uvm_object` creation and registration
- Factory registration methods
- Field macros for:
  - int, string, real, enum
  - static arrays, dynamic arrays, queues, associative arrays
- Field flags:
  - `UVM_DEFAULT`
  - `UVM_NOCOPY`
  - `UVM_NOCOMPARE`
  - radix and format flags

---

### 🔹 Print, Copy, Clone & Compare
- `print()` with different printers
- Shallow copy vs deep copy
- `copy()` behavior
- `clone()` behavior
- Object comparison using `compare()`
- Comparison control using field flags

---

### 🔹 Object-Oriented Concepts in UVM
- Inheritance and hierarchy
- Parent–child object relationships
- Virtual vs **non-virtual methods**
- Method overriding behavior
- Impact of non-virtual methods in verification design

---

### 🔹 UVM Testbench Development
- Transaction (sequence item) modeling
- Sequences and sequencers
- Driver, monitor, and agent
- Environment and test creation
- Phasing and component connectivity
- Configuration database usage

---

### 🔹 Advanced Topics (Planned)
- Reusable and configurable agents
- Layered and virtual sequences
- Functional coverage
- Scoreboards and checking strategies
- Debug, performance, and best practices

---

## 📁 Repository Structure

```text
uvm-from-basics-to-advanced/
├── basics/
├── reporting/
├── verbosity/
├── objects/
├── field_macros/
├── methods/
├── copy_clone_compare/
├── sequences/
├── agents/
├── env/
├── tests/
└── README.md
