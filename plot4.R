# plot4.R

# 讀取資料
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, sep = ";", 
                   na.strings = "?")

# 日期轉換
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# 篩選日期
subset_data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# 合併時間欄位
datetime <- as.POSIXct(paste(subset_data$Date, subset_data$Time))

# 清理後資料
subset_data <- na.omit(cbind(datetime, subset_data))

# 畫圖並輸出成 PNG
png("plot4.png", width = 480, height = 480, bg = "white")

# 設定為 2x2 的畫面
par(mfrow = c(2, 2))

# 第1張：Global Active Power
plot(subset_data$datetime, subset_data$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power",xaxt = "n")
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))
# 第2張：Voltage
plot(subset_data$datetime, subset_data$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage",xaxt = "n")
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))

# 第3張：Energy sub metering（三條線）
plot(subset_data$datetime, subset_data$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering",xaxt = "n")
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))
lines(subset_data$datetime, subset_data$Sub_metering_2, col = "red")
lines(subset_data$datetime, subset_data$Sub_metering_3, col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "n")  # bty="n" 移除 legend 邊框，符合官方圖

# 第4張：Global Reactive Power
plot(subset_data$datetime, subset_data$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power",xaxt = "n")
axis.POSIXct(1, at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             labels = c("Thu", "Fri", "Sat"))

dev.off()

