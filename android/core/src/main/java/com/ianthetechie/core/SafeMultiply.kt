package com.ianthetechie.core

import uniffi.foobar.BinaryOperator
import uniffi.foobar.ComputationException

class SafeMultiply : BinaryOperator {
  override fun perform(lhs: Long, rhs: Long): Long {
    try {
      return Math.multiplyExact(lhs, rhs)
    } catch (e: ArithmeticException) {
      throw ComputationException.Overflow()
    }
  }
}
