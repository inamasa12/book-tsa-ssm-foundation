# Training

# Ctrl + Shift + N: Create an New File
# Ctrl + S: Save the file

# Ctrl + Enter: run current row

# Ctrl + Shift + C: Comment Out

# Ctrl + Shift + R: Section

# Alt + Shift + J: move cursol


# Calculation -------------------------------------------------------------

1 + 1
4 - 2
2 * 3
6 / 4

a <- 3
a + 1
class(a)

# Function ----------------------------------------------------------------

sqrt(4)
hensu <- 2
sqrt(hensu)
?sqrt

plusOne <- function(x){
  return(x + 1)
}
plusOne(5)
class(plusOne)

# Vector ------------------------------------------------------------------

vec <- c(1, 3, 5, 6)
2:7
# Index starts from 1
vec[2]
vec[1:2]
# broadcast
vec + 2
class(vec)

# Matrix ------------------------------------------------------------------

mat <- matrix(
  c(1:8),
  nrow = 4
)
mat
class(mat)
mat <- matrix(
  c(1:8),
  ncol = 4
)
mat
ncol(mat)
nrow(mat)
mat_byrow <- matrix(
  c(1:8),
  ncol = 4,
  byrow = T
)
mat_byrow
mat_byrow[2, 1]
mat_with_name <- matrix(
  c(1:8),
  ncol = 4,
  byrow = T,
  dimnames = list(c("row1", "row2"), c("col1", "col2", "col3", "col4"))
)
mat_with_name


# DataFrame ---------------------------------------------------------------

dataf <- data.frame(
  X = c(1:4),
  Y = c("A", "B", "C", "D")
)
dataf
class(dataf)
ncol(dataf)
nrow(dataf)
dataf$X
dataf$X[1]
dataf[1, 1]
dataf_by_mat <- as.data.frame(mat)
dataf_by_mat
class(dataf_by_mat)
as.matrix(dataf)


# List --------------------------------------------------------------------

li <- list(
  dataf = dataf,
  mat = mat
)
li
class(li)
li$dataf
class(li$dataf)
li[[1]]

# Package -----------------------------------------------------------------

# Install

# High level Time Series Type
install.packages("xts") 
# Construct Time Series Model & Forecast
install.packages("forecast")
# Unit Root Inference
install.packages("urca")
# Graphic
install.packages("ggplot2")
install.packages("ggfortify")
# Time Series Functions
install.packages("tseries")

# Load
library(xts)
library(forecast)
library(urca)
library(ggplot2)
library(ggfortify)
library(tseries)

# Time Series Type --------------------------------------------------------

ts_sample <- ts(1:36, start=c(2000, 1), freq=12)
ts_sample
ts_freq4 <- ts(c(1, 4, 7, 3, 9, 2, 5, 3), start=c(2000, 1), freq=4)
ts_freq4
ts_multi <- ts(mat_with_name, start=c(2000, 1), freq=12)
ts_multi
#2000/2Q-2001/1Q
window(ts_freq4, start=c(2000, 2), end=c(2001, 1))


# MultiVariate TS --------------------------------------------------------------------

class(Seatbelts[, ])
head(Seatbelts[, ], n=3)
Seatbelts[, "front"]
Seatbelts[, c("front", "PetrolPrice")]
subset(Seatbelts[, "front"], month=3)


# xts ---------------------------------------------------------------------

xts_sample <- as.xts(matrix(
  1:5,
  dimnames = list(
    c("2000-01-01", "2000-01-02", "2000-01-03", "2000-01-04", "2000-01-05")
  ),
  ncol=1
))
xts_sample
xts_sample["2000-01-02"]
xts_sample["2000-01-02::"]
xts_sample["2000-01-02::2000-01-04"]


# Import ------------------------------------------------------------------

file_data <- read.csv(("c:/Users/mas/Anaconda3/PythonScripts/TS/book-tsa-ssm-foundation/book-data/5-2-1-timeSeries.csv"))
file_data
head(file_data, n=2)
file_data_2 <- read.csv(file.choose())
file_data_3 <- read.delim("clipboard")
class(file_data)
file_data_xs <- as.xts(
  read.zoo(file_data)
)
file_data_xs
class(file_data$data)
class(file_data_xs)


# Graphic -----------------------------------------------------------------

head(Seatbelts, n=5)
class(Seatbelts)
plot(
  Seatbelts[, "front"],
  main="イギリスの交通事故死傷者数（前席）",
  xlab="年",
  ylab="死傷者数"
)

autoplot(
  Seatbelts[, "front"],
  main="イギリスの交通事故死傷者数（前席）",
  xlab="年",
  ylab="死傷者数"
)


# Unit Root ---------------------------------------------------------------

summary(ur.kpss(log(Seatbelts[, "front"])))
ndiffs(log(Seatbelts[, "front"]))


# Seatbelts ---------------------------------------------------------------

front <- Seatbelts[, "front"]
autoplot(
  front
  #log_front
  #Seatbelts[, "PetrolPrice"]
  #Seatbelts[, "law"]
)
head(Seatbelts, n=3)
#log
log_front <- log(front)
ggtsdisplay(log_front, main="対数系列")
summary(ur.kpss(log_front))
ndiffs(log_front)
#diff
front
lag(front, -1)
lag(front, 1)
front - lag(front, -1)
diff(front, lag=1)
#log&diff
log_diff <- diff(log_front)
ggtsdisplay(log_diff, main="対数差分系列")
ur.kpss(log_diff)
ndiffs(log_diff)
#Seasonality
ggsubseriesplot(front)

