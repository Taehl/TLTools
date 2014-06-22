require "Tserial"

test1 =
		{
			hello = "world!",
			1, "love",
			key = "value",
			true, true, ["false"] = "true",
			{inner = "table"}
		}

serial1 = TSerialize(test1)
print(serial1)

loadstring("test2="..serial1)()
serial2 = TSerialize(test2)
print(serial2)
