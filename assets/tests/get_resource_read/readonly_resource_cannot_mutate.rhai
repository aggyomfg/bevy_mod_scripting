// Test that read-only resource references cannot be mutated
// TODO: Add error checking when mutation is attempted (unsure how to test at module level in Rhai)
let TestResource = world.get_type_by_name.call("test_utils::test_data::TestResource");

// Get read-only reference to TestResource
let resource_read = world.get_resource_read.call(TestResource);
if type_of(resource_read) == "()" {
    throw "Should get read-only TestResource";
}

// Verify we can read from it
let bytes = resource_read.bytes;
if type_of(bytes) == "()" {
    throw "Should be able to read bytes field";
}
print("Read bytes successfully");
