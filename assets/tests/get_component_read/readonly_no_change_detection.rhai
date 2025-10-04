// Test that get_component_read does NOT trigger Bevy's change detection
// by verifying the changed tick stays the same after read-only access

let TestComponent = world.get_type_by_name.call("test_utils::test_data::TestComponent");
let entity = world._get_entity_with_test_component.call("TestComponent");

// Get the initial change ticks
let tick_before = world.get_component_ticks.call(entity, TestComponent);
if type_of(tick_before) == "()" {
    throw "Should be able to get change ticks";
}
let tick_before_val = tick_before.changed.get.call();

// Access the component multiple times with read-only access
for i in 0..3 {
    let comp_read = world.get_component_read.call(entity, TestComponent);
    if type_of(comp_read) == "()" {
        throw "Should be able to get component read-only";
    }
    
    // Actually read the component data to ensure it's dereferenced
    let strings = comp_read.strings;
    if type_of(strings) == "()" {
        throw "Should be able to read strings";
    }
    let initial_value = strings[0];
    assert(initial_value == "Initial", `Should read initial value, got: ${initial_value}`);
    
    // Check ticks haven't changed
    let tick_check = world.get_component_ticks.call(entity, TestComponent);
    if type_of(tick_check) == "()" {
        throw "Should be able to get change ticks";
    }
    let tick_check_val = tick_check.changed.get.call();
    
    assert(tick_before_val == tick_check_val,
        `Read-only access should NOT trigger change detection (iteration ${i}). Before: ${tick_before_val}, After: ${tick_check_val}`);
}
