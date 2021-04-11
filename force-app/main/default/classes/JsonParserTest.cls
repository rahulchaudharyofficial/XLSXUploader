@IsTest
private class JsonParserTest {
    @IsTest
    static void test() {
        String sample='{ "destination_addresses" : [ "Bengaluru, Karnataka, India" ], "origin_addresses" : [ "Hyderabad, Telangana, India" ], "rows" : [ { "elements" : [ { "distance" : { "text" : "576 km", "value" : 575574 }, "duration" : { "text" : "8 hours 33 mins", "value" : 30763 }, "status" : "OK" } ] } ], "status" : "OK" }';
        JsonParser.parse(sample);
    }
}