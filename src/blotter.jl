"""
Financial blotter type: keeps track of filled transactions
for one specific instrument.
"""
type Blotter <: AbstractTimeSeries
  series::TimeArray{Float64,2}
  ticker::Ticker
end

"""
Blotter type outer constructor with `TimeArray` components.
"""
function Blotter(timestamp::Union(Vector{Date}, Vector{DateTime}),
                 values::Matrix{Float64},
                 colnames::Vector{ASCIIString},
                 ticker::Ticker)
  # utilize TimeArray inner-constructor checks
  return Blotter(TimeArray(timestamp, values, colnames), ticker)
end

"Standard blotter columns for filled transactions"
const blottercolnames = ["Qty", "Fill"]

const blotterticker   = Ticker("ticker")

Blotter() = Blotter([DateTime(1795,10,31)], [0.0 0.0], blottercolnames, blotterticker)



### TODO use push! or other non-deprecated Base-method

# this probably blows up if you try to insert vs add the end
#add!(b::Blotter, entry::Blotter) = Blotter(vcat(b.timestamp, entry.timestamp), vcat(b.values, entry.values), blottercolnames, blotterticker)



"""
Backtesting blotter for instrument series `fts` based on `signal`.
...
Returns `Blotter`-object.
"""
function Blotter(signal::TimeArray{Bool,1}, fts::FinancialTimeSeries{Float64,2};
                 quantity = 100, price = "open", slippage = .1)
  op, cl = fts["Open"], fts["Close"]
    tt = lag(signal)              # 495 row of bools, the next day
    t  = discretesignal(tt)  # 78 rows of first true and first false, as floats though

    price == "open" ?
    fills = op[datetolastsecond([t.timestamp])] :
    price == "close" ?
    fills = cl[datetolastsecond([t.timestamp])] :
    error("only open and close prices supported for naive backtests")

    notsigned  = TimeArray(t.timestamp, quantity * ones(length(t)), ["Qty"])
    exitdates  = findwhen(t.==0)
    qty        = quantity * ones(length(t.timestamp))

    for i in 1:length(notsigned)
        for j in 1:length(exitdates)
            if notsigned[i].timestamp[1] == exitdates[j]
                qty[i] = qty[i] * -1
            end
        end
    end

   datetimes = datetolastsecond(t.timestamp)

   Blotter(datetimes, [qty fills.values], blottercolnames, fts.instrument.ticker)
end
