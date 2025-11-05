namespace Uniffi.Calculator;

public class SafeCalculator
{
    // Internal calculator instance
    private Calculator _calc = new();

    // Operation objects (from UniFFI bindings)
    private readonly BinaryOperator _addOp = FoobarMethods.SafeAdditionOperator();
    private readonly SafeMultiply _mulOp = new SafeMultiply();

    // Last computation result
    public ComputationResult LastValue => _calc.LastResult();

    /// <summary>
    /// Adds two numbers together and returns the result.
    /// Throws if the result overflows.
    /// </summary>
    public ComputationResult Add(long lhs, long rhs)
    {
        _calc = _calc.Calculate(_addOp, lhs, rhs);
        return _calc.LastResult(); // Safe: will not be null at this point
    }

    /// <summary>
    /// Chains addition using the previous computation result.
    /// Throws if the result overflows or there is no previous state.
    /// </summary>
    public ComputationResult ChainAdd(long rhs)
    {
        _calc = _calc.CalculateMore(_addOp, rhs);
        return _calc.LastResult();
    }

    /// <summary>
    /// Multiplies two numbers and returns the result.
    /// Throws if the result overflows.
    /// </summary>
    public ComputationResult Mul(long lhs, long rhs)
    {
        _calc = _calc.Calculate(_mulOp, lhs, rhs);
        return _calc.LastResult();
    }

    /// <summary>
    /// Chains multiplication using the previous computation result.
    /// Throws if the result overflows or there is no previous state.
    /// </summary>
    public ComputationResult ChainMul(long rhs)
    {
        _calc = _calc.CalculateMore(_mulOp, rhs);
        return _calc.LastResult();
    }
}