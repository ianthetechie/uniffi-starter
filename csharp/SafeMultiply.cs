namespace Uniffi.Calculator;

public class SafeMultiply : BinaryOperator
{
    public long Perform(long lhs, long rhs)
    {
        try
        {
            checked
            {
                return lhs * rhs;
            }
        }
        catch (OverflowException)
        {
            throw new ArithmeticException("Multiplication overflow");
        }
    }
}