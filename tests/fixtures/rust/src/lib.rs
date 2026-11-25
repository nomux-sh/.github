//! Fixture crate for the self-test of the reusable Rust workflow.

/// Returns the sum of two numbers.
///
/// ```
/// assert_eq!(ci_fixture::add(2, 3), 5);
/// ```
#[must_use]
pub fn add(left: u32, right: u32) -> u32 {
    left + right
}

#[cfg(test)]
mod tests {
    use super::add;

    #[test]
    fn adds_two_numbers() {
        assert_eq!(add(2, 2), 4);
    }
}
