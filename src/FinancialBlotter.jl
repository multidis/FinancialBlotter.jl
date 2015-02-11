module FinancialBlotter

# documentation
using Docile

if VERSION < v"0.4-"
  using Dates
else
  using Base.Dates
end
using Reexport
@reexport using TimeSeries, FinancialSeries

import Base: show, getindex #, add!

@document

export Blotter, Portfolio, Account, Trade, tradearray,
       blottercolnames, blotterticker,
       #add!,
       merge, parsedatetime, parsedatetime1, parsedatetime_from_TOS, makedatetime, datetolastsecond, discretesignal,
       startedtrades, closedtrades

# Phase 2 methods and const
#        OrderBook,
#        orderbookcolnames, orderbookbidvalues, orderbookoffervalues, orderbooksellvalues, orderbookcovervalues, orderbookticker,
#        fillorderbook, fillblotter

include("blotter.jl")
include("trades.jl")
include("portfolio.jl")
include("account.jl")
include("show.jl")
include("getindex.jl")
# include("utilities.jl")
# include("readwrite.jl")

# include("Phase2/blotter1.jl")
# include("Phase2/orderbook.jl")
# include("Phase2/trades.jl")
# include("Phase2/statemachine.jl")

end
