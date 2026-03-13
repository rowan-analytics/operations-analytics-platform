

# Tri-State Momentum

Tri-State Momentum is a **risk-regime classification model** designed to identify **positive (risk-on), neutral, and negative (risk-off)** market environments using volatility-adjusted trend and momentum filters.

The indicator combines **Bollinger Band positioning, ATR-based trend deviation, and percentile momentum thresholds** to isolate statistically significant directional conditions while filtering out low-volatility noise.

---

## Model Summary

| Property | Description |
|--------|-------------|
| Model Type | Regime Classification Oscillator |
| Signal States | +1 (Positive), 0 (Neutral), -1 (Negative) |
| Core Inputs | Price, Bollinger Bands, ATR, Percentile Momentum |
| Filters | Volatility Expansion, Trend Deviation |
| Objective | Risk regime identification and capital preservation |
| Use Case | Systematic trading models, regime filters, portfolio allocation |

---

## Regime Interpretation

The oscillator separates market conditions into three distinct regimes:

| State | Value | Interpretation |
|------|------|----------------|
| Positive | +1 | Risk-on environment favoring directional exposure |
| Neutral | 0 | Capital preservation zone |
| Negative | -1 | Risk-off environment favoring defensive positioning |

When the model identifies a **positive regime**, conditions favor directional exposure.  
When a **negative regime** is detected, the model signals a **risk-off environment**.

The **neutral state functions as a capital preservation zone**, indicating periods where market structure lacks sufficient momentum, volatility expansion, or directional confirmation. Remaining neutral during these conditions helps avoid **over-reliance on potentially overfit signals commonly observed in low-conviction environments**.

This tri-state framework allows strategies to **participate during strong directional phases while reducing exposure during uncertain regimes**, improving overall **risk-adjusted performance**.

---

# Model Architecture

## Bollinger Band Positioning

The model measures **price location within the Bollinger Band envelope** using a normalized band percentage.

This provides a **volatility-normalized measure of price location**, helping determine whether price is positioned within:

- Upper volatility range *(bullish pressure)*
- Lower volatility range *(bearish pressure)*

Signals are only triggered when price moves beyond configurable **upper or lower thresholds**.

---

## Volatility Trend Filter

A **smoothed RMA baseline combined with ATR deviation** is used to determine whether price has moved meaningfully away from its mean.

**Bullish condition**
