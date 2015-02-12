# FinancialBlotter

## Exported
---

#### Blotter(signal::TimeArray{Bool, 1}, fts::FinancialTimeSeries{Float64, 2, M<:Union(AbstractInstrument, AbstractCurrency)})
Backtesting blotter for instrument series `fts` based on `signal`.
...
Returns `Blotter`-object.


**source:**
[FinancialBlotter/src/blotter.jl:42](https://github.com/multidis/FinancialBlotter.jl/tree/d8806475eeb9eec54eeeec100929d59382363354/src/blotter.jl#L42)

---

#### Blotter(timestamp::Union(Array{DateTime, 1}, Array{Date, 1}), values::Array{Float64, 2}, colnames::Array{ASCIIString, 1}, ticker::Ticker)
Blotter type outer constructor with `TimeArray` components.


**source:**
[FinancialBlotter/src/blotter.jl:13](https://github.com/multidis/FinancialBlotter.jl/tree/d8806475eeb9eec54eeeec100929d59382363354/src/blotter.jl#L13)

---

#### Blotter
Financial blotter type: keeps track of filled transactions
for one specific instrument.


**source:**
[FinancialBlotter/src/blotter.jl:5](https://github.com/multidis/FinancialBlotter.jl/tree/d8806475eeb9eec54eeeec100929d59382363354/src/blotter.jl#L5)

---

#### blottercolnames
Standard blotter columns for filled transactions

**source:**
[FinancialBlotter/src/blotter.jl:22](https://github.com/multidis/FinancialBlotter.jl/tree/d8806475eeb9eec54eeeec100929d59382363354/src/blotter.jl#L22)


