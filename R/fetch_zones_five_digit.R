fetch_zones_five_digit <- function(origin_zip, destination_zip,
                                   show_details = FALSE,
                                   n_tries = 3,
                                   verbose = FALSE) {
  origin_zip <-
    origin_zip %>%
    prep_zip(verbose = verbose)

  destination_zip <-
    destination_zip %>%
    prep_zip(verbose = verbose)

  resp <- get_zones_five_digit(
    origin_zip, destination_zip,
    n_tries = n_tries,
    verbose = verbose
  )

  if (resp$OriginError != "") stop("Invalid origin zip.")
  if (resp$DestinationError != "") stop("Invalid destination zip.")

  zone <-
    resp$ZoneInformation %>%
    stringr::str_extract("The Zone is [0-9]") %>%
    stringr::str_extract("[0-9]+")

  full_response <-
    resp$ZoneInformation

  out <-
    tibble::tibble(
      origin_zip = origin_zip,
      dest_zip = destination_zip,
      zone = zone,
      specific_to_priority_mail = NA, # Default to NA
      full_response = full_response
    ) %>%
    dplyr::mutate(
      specific_to_priority_mail = full_response %>%
        stringr::str_extract(
          "except for Priority Mail services where the Zone is [0-9]"
        ) %>%
        stringr::str_extract("[0-9]")
    )

  if (show_details == TRUE) {
    out <- out %>%
      dplyr::mutate(
        local =
          ! stringr::str_detect(
            full_response, "This is not a Local Zone"
        ),
        same_ndc =
          ! stringr::str_detect(
            full_response, "The destination ZIP Code is not \\
            within the same NDC as the origin ZIP Code"
          )
      ) %>%
      dplyr::select(
        origin_zip, dest_zip, zone,
        specific_to_priority_mail, local,
        same_ndc, full_response
      )
  } else {
    out <- out %>%
      dplyr::select(origin_zip, dest_zip, zone)
  }

  return(out)
}