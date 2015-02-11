# FinancialBlotter

## Exported
---

#### Blotter(signal::TimeArray{Bool, 1}, fts::FinancialTimeSeries{Float64, 2, M<:AbstractInstrument})
Backtesting blotter for instrument series `fts` based on `signal`.
...
Returns `Blotter`-object.


**source:**
[FinancialBlotter/src/blotter.jl:37](https://github.com/multidis/FinancialBlotter.jl/tree/8863378d7e9d56f54de07761932849f9bf5c2fc3/src/blotter.jl#L37)

---

#### Blotter(timestamp::Union(Array{Date, 1}, Array{DateTime, 1}), values::Array{Float64, 2}, colnames::Array{ASCIIString, 1}, ticker::Ticker)
Blotter type outer constructor with `TimeArray` components.


**source:**
[FinancialBlotter/src/blotter.jl:13](https://github.com/multidis/FinancialBlotter.jl/tree/8863378d7e9d56f54de07761932849f9bf5c2fc3/src/blotter.jl#L13)

---

#### Blotter
Financial blotter type: keeps track of filled transactions
for one specific instrument.


**source:**
[FinancialBlotter/src/blotter.jl:5](https://github.com/multidis/FinancialBlotter.jl/tree/8863378d7e9d56f54de07761932849f9bf5c2fc3/src/blotter.jl#L5)

---

#### blottercolnames
Standard blotter columns for filled transactions

**source:**
[FinancialBlotter/src/blotter.jl:23](https://github.com/multidis/FinancialBlotter.jl/tree/8863378d7e9d56f54de07761932849f9bf5c2fc3/src/blotter.jl#L23)


