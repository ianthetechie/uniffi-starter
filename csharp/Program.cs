using Uniffi.Calculator;

var calculator = new SafeCalculator();
Console.WriteLine($"Hello, World! 2+20={calculator.Add(2, 20).value}");