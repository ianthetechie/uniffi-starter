/**
 * FIXME: This file should move out of Android Tests ASAP. It only exists here because I haven't yet
 * figured out how to build and link the platform-native binaries via JNI just yet and this works.
 * See https://github.com/willir/cargo-ndk-android-gradle/issues/12.
 *
 * This solution is STUPIDLY INEFFICIENT and will probably contribute to global climate change since
 * an Android emulator uses like two whole CPU cores when idling.
 */
package com.ianthetechie.foobar.core

import com.ianthetechie.core.SafeCalculator
import org.junit.Assert.*
import org.junit.Test

class SafeCalculatorTest {
  private val calculator = SafeCalculator()

  @Test
  fun addition() {
    val res = calculator.add(2, 2)
    assertEquals(4, res.value)

    val res2 = calculator.chainAdd(7)
    assertEquals(11, res2.value)
  }

  @Test
  fun multiplication() {
    val res = calculator.mul(2, 4)
    assertEquals(8, res.value)

    val res2 = calculator.chainMul(3)
    assertEquals(24, res2.value)
  }
}
