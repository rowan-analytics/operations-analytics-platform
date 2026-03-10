## DCA — MULTI YEAR VALUATION MODEL

The SDCA component is a multi-factor Bitcoin valuation model that normalizes several long-term valuation inputs into a single composite score.

Core normalization logic
rescale(value, fromMin, fromMax, toMin, toMax) =>
    (value - fromMin) / (fromMax - fromMin) * (toMax - toMin) + toMin

zscore(srcvalue, lenvalue) =>
    mean = ta.sma(srcvalue, lenvalue)
    stdev = ta.stdev(srcvalue, lenvalue) 
    (srcvalue - mean) / stdev

---

### Signal Use Case

The SDCA engine is not intended for short-term trading.  
It is designed for:

- long-term accumulation planning
- staged capital deployment
- identifying historically favorable DCA zones
- reducing exposure during overheated valuation conditions

---

### Onchain Input

MC = request.security("GLASSNODE:BTC_MARKETCAP", "D", close)
MCR = request.security("COINMETRICS:BTC_MARKETCAPREAL", "D", close)

var MCap = array.new_float()
array.push(MCap, MC)
stdevs = array.stdev(MCap)
MVRVvaluation = (MC - MCR) / stdevs
MVRVZ = rescale(MVRVvaluation, -0.25, 6.85, 2.5, -2.5)

---

### DCA Valuation Zones

var string interpretation = ""

if avg >= 2
    interpretation := "Strongly Undervalued"
else if avg > 1.5
    interpretation := "Moderately Undervalued"
else if avg > 0.5
    interpretation := "Slightly Undervalued"
else if avg > -0.5
    interpretation := "Fair Valued"
else if avg > -1.5
    interpretation := "Slightly Overvalued"
else if avg > -2
    interpretation := "Moderately Overvalued"
else
    interpretation := "Strongly Overvalued"

---

### Quantitative Features Demonstrated

This component demonstrates:

- multi-factor valuation modeling
- normalization and rescaling logic
- Z-score standardization
- category-level aggregation
- interpretable regime classification
- portfolio-oriented signal design

---

### Output

The final SDCA output is a **single composite valuation score** that feeds into the broader allocation framework and helps determine whether current market conditions favor:

- **DCA IN**
- **HOLD**
- **DCA OUT**
- **SELL**
