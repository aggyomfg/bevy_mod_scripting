-- Test that read-only resource references cannot be mutated
local TestResource = world.get_type_by_name("test_utils::test_data::TestResource")

-- Get read-only reference to TestResource
local resource_read = world.get_resource_read(TestResource)
assert(resource_read ~= nil, "Should get read-only TestResource")

-- Verify we can read from it
local bytes = resource_read.bytes
assert(bytes ~= nil, "Should be able to read bytes field")
print("Read bytes length: " .. tostring(#bytes))

-- Try to mutate - this should error
local success, err = pcall(function()
    resource_read.bytes[1] = 99 -- Try to modify array element
end)

assert(not success, "Mutation should have failed")
local err_str = tostring(err)
assert(string.find(err_str, "read%-only") or string.find(err_str, "mutate"),
    "Error should mention read-only or mutation restriction, got: " .. err_str)
