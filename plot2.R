# plot2.R

# 讀取資料
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, sep = ";", 
                   na.strings = "?")

# 日期轉換
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# 篩選 2007/2/1 和 2007/2/2
subset_data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# 合併日期與時間，並轉為 POSIXct（時間軸才會順）
datetime <- as.POSIXct(paste(subset_data$Date, subset_data$Time))

# 結合成乾淨的資料框並排除 NA
plot_data <- data.frame(datetime, gap = subset_data$Global_active_power)
plot_data <- na.omit(plot_data)

# 畫圖
png("plot2.png", width = 480, height = 480, bg = "white")
plot(plot_data$datetime, plot_data$gap,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     xaxt = "n")  # 不畫預設 x 軸

# 自訂 x 軸：加上三個標籤位置
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))
dev.off()
