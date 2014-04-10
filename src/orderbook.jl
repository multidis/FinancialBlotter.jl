import Base: show, getindex, length

#type OrderBook{T,N} <: AbstractTimeSeries
type OrderBook <: AbstractTimeSeries

    timestamp::Vector{Date{ISOCalendar}}
    values::Matrix{ASCIIString}
    colnames::Vector{ASCIIString}
#    timeseries::Stock

    #function OrderBook(timestamp::Vector{Date{ISOCalendar}}, values::Array{T,N}, colnames::Vector{ASCIIString})
    function OrderBook(timestamp::Vector{Date{ISOCalendar}}, values::Matrix{ASCIIString}, colnames::Vector{ASCIIString})
        nrow, ncol = size(values, 1), size(values, 2)
        nrow != size(timestamp, 1) ? error("values must match length of timestamp"):
        ncol != size(colnames,1) ? error("column names must match width of array"):
        timestamp != unique(timestamp) ? error("there are duplicate dates"):
        ~(flipud(timestamp) == sort(timestamp) || timestamp == sort(timestamp)) ? error("dates are mangled"):
        flipud(timestamp) == sort(timestamp) ? 
        new(flipud(timestamp), flipud(values), colnames):
        new(timestamp, values, colnames)
    end
#    OrderBook(timestamp::Vector{Date{ISOCalendar}}) = OrderBook(timestamp, zeros(length(timestamp), 2), ["Qty","Fill"])
end

#OrderBook{T,N}(d::Vector{Date{ISOCalendar}}, v::Array{T,N}, c::Vector{ASCIIString}) = OrderBook{T,N}(d,v,c)
#OrderBook(d::Vector{Date{ISOCalendar}}, v::Matrix{ASCIIString}, c::Vector{ASCIIString}) = OrderBook(d,v,c)
#OrderBook{T,N}(d::Date{ISOCalendar}, v::Array{T,N}, c::Array{ASCIIString,1}) = OrderBook([d], v, c)
OrderBook(d::Date{ISOCalendar}, v::Matrix{ASCIIString}, c::Vector{ASCIIString}) = OrderBook([d], v, c)
#OrderBook(d::Vector{Date{ISOCalendar}}) = OrderBook(d,zeros(length(d),2),["Qty","Fill"])
#OrderBook(d::Vector{Date{ISOCalendar}}) = OrderBook(d,string(zeros(length(d),3)),["Qty","Fill", "Status"])
initialdate = [date(1980,1,3), date(1980,1,12)]
initialvals = ["100" "123.12" "short" "market" "open" "" "2.33";
               "100" "120.12" "cover" "market" "pending" "" "2.33"]
initialcols = ["Qty","Price","Side","Order Type", "Status", "Status Time", "Fees"]
OrderBook() = OrderBook(initialdate, initialvals, initialcols) 

###### length ###################

# function length(b::OrderBook)
#     length(b.timestamp)
# end

###### show #####################

function show(io::IO, ta::OrderBook)
  # variables 
  nrow          = size(ta.values, 1)
  ncol          = size(ta.values, 2)
  spacetime     = strwidth(string(ta.timestamp[1])) + 3
  firstcolwidth = strwidth(ta.colnames[1])
  colwidth      = Int[]
      for m in 1:ncol
          push!(colwidth, max(strwidth(ta.colnames[m]), maximum([strwidth(t) for t in ta.values[:,m]])))
      end

  # summary line
  print(io,@sprintf("%dx%d %s %s to %s", nrow, ncol, typeof(ta), string(ta.timestamp[1]), string(ta.timestamp[nrow])))
  println(io,"")
  println(io,"")

  # row label line
   print(io, ^(" ", spacetime), ta.colnames[1], ^(" ", colwidth[1] + 2 -firstcolwidth))

   for p in 2:length(colwidth)
     print(io, ta.colnames[p], ^(" ", colwidth[p] - strwidth(ta.colnames[p]) + 2))
   end
   println(io, "")
 
  # timestamp and values line
   #  if nrow > 7
   #      for i in 1:4
   #          print(io, ta.timestamp[i], " | ")
   #      for j in 1:ncol
   #          print(io, rpad(ta.values[i,j], colwidth[j] + 2, " "))
   #      end
   #      println(io,"")
   #      end
   #      println(io,'\u22EE')
   #      for i in nrow-3:nrow
   #          print(io, ta.timestamp[i], " | ")
   #      for j in 1:ncol
   #          print(io, rpad(ta.values[i,j], colwidth[j] + 2, " ")) 
   #      end
   #      println(io,"")
   #      end
   #  else
        for i in 1:nrow
            print(io, ta.timestamp[i], " | ")
        for j in 1:ncol
            ta.values[i,j] == "open" || ta.values[i,j] == "long" ?
            #ta.values[i,j] == "open" ?
            print_with_color(:green, io, rpad(ta.values[i,j], colwidth[j] + 2, " ")) :
            ta.values[i,j] == "closed" || ta.values[i,j] == "short" ?
            #ta.values[i,j] == "closed" ?
            print_with_color(:red, io, rpad(ta.values[i,j], colwidth[j] + 2, " ")) :
            ta.values[i,j] == "pending" || ta.values[i,j] == "cover" || ta.values[i,j] == "sell" ?
            print_with_color(:yellow, io, rpad(ta.values[i,j], colwidth[j] + 2, " ")) :
            print_with_color(:blue, io, rpad(ta.values[i,j], colwidth[j] + 2, " ")) 
        end
        println(io,"")
        end
   # end
end

###### getindex #################

# single row
function getindex(b::OrderBook, n::Int)
    OrderBook(b.timestamp[n], b.values[n,:], b.colnames)
end

# range of rows
function getindex(b::OrderBook, r::Range1{Int})
    OrderBook(b.timestamp[r], b.values[r,:], b.colnames)
end

# array of rows
function getindex(b::OrderBook, a::Array{Int})
    OrderBook(b.timestamp[a], b.values[a,:], b.colnames)
end

# single column by name 
function getindex(b::OrderBook, s::ASCIIString)
    n = findfirst(b.colnames, s)
    OrderBook(b.timestamp, b.values[:, n], ASCIIString[s])
end

# array of columns by name
function getindex(b::OrderBook, args::ASCIIString...)
    ns = [findfirst(b.colnames, a) for a in args]
    OrderBook(b.timestamp, b.values[:,ns], ASCIIString[a for a in args])
end

# single date
function getindex(b::OrderBook, d::Date{ISOCalendar})
   for i in 1:length(b)
     if [d] == b[i].timestamp 
       return b[i] 
     else 
       nothing
     end
   end
 end
 
# range of dates
function getindex(b::OrderBook, dates::Array{Date{ISOCalendar},1})
  counter = Int[]
#  counter = int(zeros(length(dates)))
  for i in 1:length(dates)
    if findfirst(b.timestamp, dates[i]) != 0
      #counter[i] = findfirst(b.timestamp, dates[i])
      push!(counter, findfirst(b.timestamp, dates[i]))
    end
  end
  b[counter]
end

function getindex(b::OrderBook, r::DateRange{ISOCalendar}) 
    b[[r]]
end

# day of week
# getindex{T,N}(b::OrderBook{T,N}, d::DAYOFWEEK) = b[dayofweek(b.timestamp) .== d]
