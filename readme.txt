For more documentation and examples, go to http://wiki.github.com/Taehl/TLTools/

Tools:

TSerial: Converts tables into strings. That way you can save tables to files, or send them across a network. Currently only supports tables with keys that are strings or numbers, and values that are strings, numbers, tables, or booleans.
- TSerialize(table) returns a string of the Lua code which will recreate the table.
- To deserialize, use loadstring("table="..serial)().

TLibCompress: Can zip andd unzip strings, reducing their size. A good way to save bandwidth when sending strings across a network.
- TLibCompress.CompressLZW(string) returns a zipped string
- TLibCompress.UncompressLZW(string) returns an unzipped version of a zipped string