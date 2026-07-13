# 多周期指令的数据通路

单周期CPU中大部分指令在一个时钟周期内完成，但有两类特殊指令需要多个周期：

## 需要多周期的指令
1. **访存指令** (lb/lbu/lh/lhu/lw/sb/sh/sw)：发出访存请求后需等待Cache/主存响应
2. **乘除法指令** (mul/mulh/div/rem等)：乘除法运算需要多个时钟周期

## 实现方法

核心思路：检测到多周期指令时，用寄存器缓存相关信号，等操作完成后再写回。

```verilog
// 1. 标志位：正在执行访存/乘除法指令
assign is_ld_st = (ram_rop != `RAM_EXT_N) | (ram_wop != `RAM_WE_N);
always @(posedge cpu_clk or posedge cpu_rst) begin
    if      (cpu_rst)    ld_st_flag <= 1'b0;
    else if (is_ld_st)   ld_st_flag <= 1'b1;
    else if (ld_st_done) ld_st_flag <= 1'b0;
end

// 2. 缓存目标寄存器号
always @(posedge cpu_clk) begin
    if (is_ld_st | is_mul_div) rf_wR_r <= inst[11:7];
end

// 3. 缓存访存地址
always @(posedge cpu_clk) if (is_ld_st) alu_c_r <= alu_c;

// 4. 访存结束条件
assign ld_st_done = daccess_rvalid | daccess_wresp;

// 5. 写回条件
assign rf_we1 = ld_st_flag   & daccess_rvalid |
                mul_div_flag & !mul_div_busy  |
                ifetch_valid & rf_we & !is_ld_st & !is_mul_div;
```
