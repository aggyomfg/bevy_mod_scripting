-- Test that mutable resource references can be mutated
local TestResource = world.get_type_by_name("test_utils::test_data::TestResource")

-- Get mutable reference to TestResource
local resource_mut = world.get_resource_mut(TestResource)
assert(resource_mut ~= nil, "Should get mutable TestResource")

-- Read initial value
local initial_byte = resource_mut.bytes[1]
print("Initial bytes[1]: " .. tostring(initial_byte))

-- Mutate - this should work
resource_mut.bytes[1] = 42

-- Verify the mutation worked
local resource_check = world.get_resource_read(TestResource)
assert(resource_check.bytes[1] == 42,
    "Mutation should have changed bytes[1] to 42, but got: " .. tostring(resource_check.bytes[1]))
