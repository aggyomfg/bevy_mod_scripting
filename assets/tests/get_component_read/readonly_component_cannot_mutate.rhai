// Test that read-only component references cannot be mutated
// TODO: Add error checking when mutation is attempted (unsure how to test at module level in Rhai)
let TestComponent = world.get_type_by_name.call("test_utils::test_data::TestComponent");
let entity_with_test_comp = world._get_entity_with_test_component.call("TestComponent");

// Get read-only reference
let comp_read = world.get_component_read.call(entity_with_test_comp, TestComponent);
if type_of(comp_read) == "()" {
    throw "Should get read-only component";
}

// Verify we can read from it
let value = comp_read.strings[0];
print(`Read value: ${value}`);
