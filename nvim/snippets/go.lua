local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
                                                  return {
  -- Print Hello World
  s("hello", {
    t({"package main", "", "import \"fmt\"", "", "func main() {", "\tfmt.Println(\""}), i(1, "Hello Go 🚀"), t({"\")", "}"}),                           }),

  -- Struct
  s("struct", {
    t("type "), i(1, "Name"), t({" struct {", "\t"}), i(2, "Field type"), t({"", "}"}),
  }),

  -- Function
  s("func", {
    t("func "), i(1, "name"), t("("), i(2, "params"), t(") "), i(3, "returnType"), t({" {", "\t"}), i(0), t({"", "}"}),
  }),

  -- Method
  s("method", {
    t("func ("), i(1, "r Receiver"), t(") "), i(2, "MethodName"), t("("), i(3, "params"), t(") "), i(4, "returnType"), t({" {", "\t"}), i(0), t({"", "}"}),
  }),

  -- For Loop
  s("for", {
    t("for "), i(1, "i := 0; i < n; i++"), t({" {", "\t"}), i(0), t({"", "}"}),
  }),

  -- If Statement
  s("if", {
    t("if "), i(1, "condition"), t({" {", "\t"}), i(0), t({"", "}"}),
  }),

  -- Error Handling
  s("iferr", {
    t("if err != nil {"), t({"", "\treturn "}), i(1, "nil"), t(", err"), t({"", "}"}),
  }),

  -- Goroutine
  s("go", {
    t("go func() {"), t({"", "\t"}), i(0), t({"", "}()"}),
  }),

  -- Channel
  s("chan", {
    t("ch := make(chan "), i(1, "string"), t(")"),
  }),

  -- Main Boilerplate
  s("main", {
    t({"package main", "", "import (", "\t\"fmt\"", ")", "", "func main() {", "\tfmt.Println(\""}), i(1, "Hello from main"), t({"\")", "}"}),
  }),
}
