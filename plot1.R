# plot1.R

# 讀取資料
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
head(data)
# 轉換日期格式
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# 篩選出 2007/2/1 和 2/2 的資料
subset_data <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# 合併日期和時間欄位
datetime <- strptime(paste(subset_data$Date, subset_data$Time), format = "%Y-%m-%d %H:%M:%S")

# 畫圖並輸出成 plot1.png
png("plot1.png", width = 480, height = 480)
hist(subset_data$Global_active_power,col="red",xlab="Global Active Power(kilowatts)",main="Global Active Power")
dev.off()

