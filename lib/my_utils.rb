module MyUtils

	def webstatus_to_code(code)
		Rack::Utils::SYMBOL_TO_STATUS_CODE[code]
	end

end


