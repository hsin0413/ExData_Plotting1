# plot3.R

# 讀取資料
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, sep = ";", 
                   na.strings = "?")

# 日期轉換
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# 篩選出指定日期資料
subset_data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# 合併日期時間欄位為 POSIXct
datetime <- as.POSIXct(paste(subset_data$Date, subset_data$Time))

# 整合資料 + 去除 NA
plot_data <- data.frame(datetime,
                        sm1 = subset_data$Sub_metering_1,
                        sm2 = subset_data$Sub_metering_2,
                        sm3 = subset_data$Sub_metering_3)
plot_data <- na.omit(plot_data)

# 開始畫圖
png("plot3.png", width = 480, height = 480, bg = "white")

# 畫第一條線（黑色）
plot(plot_data$datetime,plot_data$sm1, type = "l",
     xlab = "", ylab = "Energy sub metering", xaxt = "n")

# 加第二條紅線
lines(plot_data$datetime, plot_data$sm2, col = "red")

# 加第三條藍線
lines(plot_data$datetime, plot_data$sm3, col = "blue")

# 加上自訂 x 軸（顯示星期）
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))

# 加圖例
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1)

dev.off()
