package com.ianthetechie.core

import uniffi.foobar.Calculator
import uniffi.foobar.ComputationResult
import uniffi.foobar.safeAdditionOperator

class SafeCalculator {
  // Functional core; imperative shell. This is purely internal state with an imperative API
  // wrapper.
  private var calc = Calculator()

  private val addOp = safeAdditionOperator()
  private val mulOp = SafeMultiply()

  val lastValue: ComputationResult?
    get() = calc.lastResult()

  /**
   * Adds two numbers together and returns the result.
   *
   * Throws a ComputationException if the result overflows.
   */
  fun add(lhs: Long, rhs: Long): ComputationResult {
    calc = calc.calculate(addOp, lhs, rhs)

    // Note that it is not possible for lastResult to be anything but
    // a computed value at this point, so we can expose a nicer
    // interface to Swift consumers of the low-level library.
    return calc.lastResult()!!
  }

  /**
   * Chains addition using the previous computation result.
   *
   * Throws a ComputationException if the result overflows or there is no previous state for this
   * calculator.
   */
  fun chainAdd(rhs: Long): ComputationResult {
    calc = calc.calculateMore(addOp, rhs)

    // Note that it is not possible for lastResult to be anything but
    // a computed value at this point, so we can expose a nicer
    // interface to Swift consumers of the low-level library.
    return calc.lastResult()!!
  }

  /**
   * Multiplies two numbers together and returns the result.
   *
   * Throws a ComputationException if the result overflows.
   */
  fun mul(lhs: Long, rhs: Long): ComputationResult {
    calc = calc.calculate(mulOp, lhs, rhs)

    // Note that it is not possible for lastResult to be anything but
    // a computed value at this point, so we can expose a nicer
    // interface to Swift consumers of the low-level library.
    return calc.lastResult()!!
  }

  /**
   * Chains multiplication using the previous computation result.
   *
   * Throws a ComputationException if the result overflows or there is no previous state for this
   * calculator.
   */
  fun chainMul(rhs: Long): ComputationResult {
    calc = calc.calculateMore(mulOp, rhs)

    // Note that it is not possible for lastResult to be anything but
    // a computed value at this point, so we can expose a nicer
    // interface to Swift consumers of the low-level library.
    return calc.lastResult()!!
  }
}
