#' @noRd
extract <- function (string) {
  # Find 'END'
  end_label <- end_pos(string)

  odl_label <- substr(string, 1, end_label)

  extra_data <- NULL
  if (nchar(string) > end_label) {
    extra_data <- substring(string, end_label + 1, nchar(string))
  }

  return(list(
    label      = trimws(odl_label),
    extra_data = trimws(extra_data)
  ))
}

#' @noRd
end_pos <- function(x) {
  lexer <- rly::lex(odl_lexer)

  # Force upper for purpose of finding END
  lexer$input(toupper(x))
  while (TRUE) {
    t <- lexer$token()
    if (is.null(t)) return (-1)
    if (t$type == "END") return(t$lexpos + 2)
  }
}
