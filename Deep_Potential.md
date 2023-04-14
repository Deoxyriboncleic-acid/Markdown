# Deep Potential

### 简单介绍

Deep Potential是一个简单而通用的**端到端深度神经网络**表示多原子势能面的方法。

该网络使用**原子的原始坐标作为输入**，并在适当的参考系中自然地尊重系统的对称性。

# 背景知识

[分子动力学](https://en.wikipedia.org/wiki/Molecular_dynamics)

[势能面](https://en.wikipedia.org/wiki/Potential_energy_surface)

[力场（化学）](https://en.wikipedia.org/wiki/Force_field_(chemistry))

[原子间势能](https://en.wikipedia.org/wiki/Interatomic_potential)

# 传统方法

第一性原理分子动力学(ab initiomolecular dynamics, **AIMD**)  

特点：速度慢，但是准确

[例子](Deep%20Potential%20a4f171192d9443d2af35530cd740e723/%E4%BE%8B%E5%AD%90%20f539baad419948fe8ea0012e2f9e61b9.md)

[经验立场](https://en.wikipedia.org/wiki/Force_field_(chemistry))

[例子](Deep%20Potential%20a4f171192d9443d2af35530cd740e723/%E4%BE%8B%E5%AD%90%20bffc5a45446d4261a39ad03deb1bc30b.md)

# 方法说明

1. 每个原子的坐标被输入到神经网络中。
2. 然后，神经网络将这些坐标转换为一组**局部对称函数（LSFs）(可以捕捉到原子之间的局部结构信息)**，这些函数描述了原子之间的相互作用。
3. 接下来，LSFs被输入到另一个神经网络中，该网络将LSFs转换为**全局对称函数（GSFs）(函数描述了整个分子的势能面)**，这些函数描述了整个分子的势能面。
4. 最后，GSFs被用于计算分子的性质和行为。

![Untitled](Deep%20Potential%20a4f171192d9443d2af35530cd740e723/Untitled.png)

# 实现主要问题

实现这个目标的主要挑战是设计一个深度神经网络，它遵循系统中重要的对称性，就像在模式识别问题中使用卷积神经网络一样。除了通常的平移和旋转对称性外，我们还有置换对称性。
