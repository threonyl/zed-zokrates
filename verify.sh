#!/bin/bash
set -e

echo "Verifying ZoKrates Extension..."

# Check for tree-sitter CLI
if ! command -v tree-sitter &> /dev/null; then
    echo "Error: tree-sitter CLI not found."
    exit 1
fi

GRAMMAR_DIR="../tree-sitter-zokrates"

echo "1. Generating parser in $GRAMMAR_DIR..."
pushd "$GRAMMAR_DIR" > /dev/null
tree-sitter generate
echo "2. Running corpus tests..."
tree-sitter test
popd > /dev/null

echo "3. Parsing sample file..."
# Create a temporary dummy file for query validation if test.zok doesn't exist
TEST_FILE="$GRAMMAR_DIR/test.zok"
if [ ! -f "$TEST_FILE" ]; then
    echo "def main() {}" > dummy.zok
    TEST_FILE="dummy.zok"
fi

# tree-sitter parse needs to run where the grammar is, or we specify paths.
# Simpler to run inside grammar dir
pushd "$GRAMMAR_DIR" > /dev/null
tree-sitter parse test.zok
popd > /dev/null

echo "4. Validating queries..."
# Function to validate a query file
validate_query() {
    local query_file=$1
    echo "Checking $query_file..."
    
    # Run from grammar dir so tree-sitter finds the grammar
    pushd "$GRAMMAR_DIR" > /dev/null
    # query_file path is relative to zed-zokrates, so we need to adjust
    if tree-sitter query "../zed-zokrates/$query_file" "test.zok" > /dev/null; then
        echo "  OK"
    else
        echo "  FAILED"
        exit 1
    fi
    popd > /dev/null
}

validate_query "languages/zokrates/highlights.scm"
validate_query "languages/zokrates/indents.scm"
validate_query "languages/zokrates/outline.scm"
validate_query "languages/zokrates/brackets.scm"

if [ -f "dummy.zok" ]; then
    rm dummy.zok
fi

echo "Verification successful!"
