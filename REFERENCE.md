# CPU 设计参考资料

课程：计算机设计与实践（2026夏季）| 哈工大（深圳）
目标：基于 miniRV (RV32I子集) 指令集，在 FPGA (xc7a100tfgg484-1) 上实现流水线 SoC

## 目录结构

```
CPU_lab/
├── REFERENCE.md                  # 本文件 - 参考资料总览
├── ref/
│   ├── course-site/              # 课程网站关键页面
│   │   ├── miniRV-isa.md         # ★ miniRV指令集详解 (37条指令)
│   │   ├── lab1-datapath.md      # 数据通路设计方法
│   │   ├── lab1-controller.md    # 控制单元设计方法
│   │   ├── lab1-multicycle.md    # 多周期指令实现 (访存/乘除)
│   │   ├── trace-test.md         # ★ Trace测试框架使用
│   │   └── faq.md                # 常见问题汇总
│   │
│   ├── reference-code/           # 参考Verilog代码 (demo工程)
│   │   ├── rv_cpu_core.v         # ★ CPU核心 (单周期, 含多cycle指令)
│   │   ├── cpu_top.v             # 顶层 (ICache+DCache+AXI)
│   │   ├── ALU.v                 # 运算器 (含乘除法器、MAC)
│   │   ├── multiplier.v          # 乘法器
│   │   ├── divider.v             # 除法器
│   │   ├── mac.v                 # 乘累加器
│   │   ├── if_wrap.v             # 取指接口包装
│   │   ├── axi_master.v          # AXI总线控制器
│   │   ├── ICache.v              # 指令Cache
│   │   └── DCache.v              # 数据Cache
│   │
│   ├── lab-ppts/                 # 实验PPT
│   │   ├── 实验2 运算器设计-PPT.pdf
│   │   └── 实验3 高速缓存器设计-PPT.pdf
│   │
│   └── exam-materials/           # 计组期末复习资料
│       ├── 期末复习资料.pdf       # 总复习 (266页)
│       └── 课件/                 # 1-7章课件
│           ├── 第1章 计算机组成原理概述.pdf
│           ├── 第2章 计算机的运算方法.pdf
│           ├── 第3章 RISC-V汇编及指令系统 (4部分)
│           ├── 第4章 处理器设计.pptx (2份)
│           ├── 第5章 流水线处理器.pptx
│           ├── 第6章 存储器.pptx
│           ├── 第7章 系统总线和输入输出 (3部分)
│           └── 计算机组成原理重难点.pdf
```

## 课程网站
完整指导书：https://cpu-design.p.cs-lab.top/

| 页面 | 内容 |
|------|------|
| 首页 | 课程任务说明、小组分工表 |
| 实验1/2-inst/ | miniRV指令集详解 |
| 实验1/3-parts/ | 功能部件设计 |
| 实验1/4-datpth/ | 数据通路设计（表格驱动法） |
| 实验1/5-ctrler/ | 控制单元设计 |
| 实验1/6-multcycle/ | 多周期指令数据通路 |
| 实验1/9-timing/ | 单周期CPU时序 |
| 实验1/10-verify/ | CPU功能验证原理 |
| 实验1/12-step/ | 实验步骤 |
| trace/trace/ | Trace测试框架 |
| home/problems/ | 常见问题汇总 |
| home/fpga/ | 开发板使用须知 |

## 实验阶段

### 实验1：单周期CPU
1. 确定数据通路表（A组/B组指令分工）
2. 设计控制信号取值表
3. 设计各功能部件 (PC, NPC, RF, ALU, SEXT, Ctrl) + 多路选择器
4. 综合为完整单周期CPU
5. 通过 Basic Trace 测试

### 实验2：流水线CPU及SoC
1. 单周期 → 理想流水线改造
2. ICache + DCache 集成
3. AXI 总线控制器
4. 流水线冒险检测 (暂停法/前递法)
5. SoC下板测试 (CoreMark / LLAMA2)

## 重要提示
- demo工程中的 PC.v, RF.v, NPC.v, SEXT.v, Ctrl.v 是Vivado综合网表，需重写为行为级RTL
- 系统复位后首条指令地址 = 0x00000000
- Trace复位信号：高电平复位
- 指令集版本：miniRV = RV32I 子集 (37条指令)
