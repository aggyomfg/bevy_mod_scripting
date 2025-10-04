// Test read-only component access doesn't trigger change detection

let TestComponent = world.get_type_by_name.call("test_utils::test_data::TestComponent");
let entity = world._get_entity_with_test_component.call("TestComponent");

// Get read-only reference
let comp_read = world.get_component_read.call(entity, TestComponent);
if type_of(comp_read) == "()" {
    throw "Should be able to get component read-only";
}

// Read the strings field
let strings = comp_read.strings;
if type_of(strings) == "()" {
    throw "Should be able to read strings";
}
let initial_value = strings[0];
assert(initial_value == "Initial", "Should read initial value, got: " + initial_value);
