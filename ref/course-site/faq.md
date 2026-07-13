# 常见问题汇总

## CPU设计
1. **数据通路图**：Visio、Visual Paradigm、draw.io、ProcessOn
2. **宏未定义**：每个.v文件添加 `include "defines.vh"`，引用时加反引号
3. **移位位数过大/负数**：截取最低5位作为有效移位位数
4. **Load指令取到0**：ALU算的是字节地址，DRAM地址是字地址；也可能是之前store写了0
5. **时钟Critical Warning**：检查是否同时使用了时钟的上升沿和下降沿
6. **AXI Trace过但下板失败**：检查DCache Uncached访问、外设访问
7. **提高主频**：看Vivado时序报告找关键路径，优化或切割
8. **及格标准（2人组）**：单周期全指令+Basic Trace + 理想流水线通过仿真 + AXI总线(lw/sw测试) + 报告
9. **及格标准（单人）**：A/B组单周期+Basic Trace + 理想流水线仿真 + I/O接口编程 + 报告

## Trace验证
1. 虚拟机启动不了 → 重启电脑3分钟内启动
2. 编译报错"multiple target patterns" → 删除Zone.Identifier文件
3. 报错"Timescale missing" → 删除 `timescale 1ns/1ps` 或加 lint_off
4. 修改代码后波形不变 → make前先 make clean
5. 所有指令Time out → 检查debug信号、模块名、复位逻辑(PC初始=0)
6. 复位信号：Trace是高电平复位；EGO1开发板是低电平复位；Minisys是高电平复位
7. 提交前确保虚拟机里Trace测试通过即可

## 下板
1. Auto Connect失败 → 检查JTAG接口、电源、拨码开关；重试Open New Target
2. 综合/实现慢 → 耐心等待；检查路径无中文空格；删除缓存文件重试
3. 组合逻辑环路 → 根据报错找环解决
4. 仿真和下板不一致 → 检查赋初值、阻塞/非阻塞赋值混用、关键路径、竞争冒险
