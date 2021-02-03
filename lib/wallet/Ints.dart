
List<int> toByteArray(int value) {
    return [value >> 24, value >> 16, value >> 8, value];
}
