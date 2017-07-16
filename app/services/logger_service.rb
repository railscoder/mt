class LoggerService
  class << self
    def call(message)
      logfile = File.open(Rails.root.join(log_dir, "error.log"), "a")
      logger = Logger.new(logfile)
      logger.error message
      logger.close
    end

    def log_dir
      dir = "log/#{date}/"
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      dir
    end

    def date
      Time.current.strftime("%d-%m-%Y")
    end
  end
end
