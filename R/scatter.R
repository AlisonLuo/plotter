#' @title
#' Create a scatter plot from a dataframe
#'
#' @description
#' The `scatter()` function creates a scatter plot from two specified numeric columns
#' in a data frame. Users can customize the plot by adjusting axis labels, colors,
#' and additional `geom_point()` function parameters.
#'
#' @details This function is a wrapper around the `pull()` function in the `dplyr` package as well as the `ggplot()` and `geom_point()` functions in the `ggplot2` package.
#' @param data A data frame containing the variables to be plotted. This parameter is named `data`
#' because it represents the main data structure required for plotting.
#' @param x The name of the variable for the x-axis, specified as a column in the data frame.
#' This parameter is named `x` to clearly indicate its role as the horizontal axis of the scatter plot.
#' @param y The name of the variable for the y-axis, specified as a column in the data frame.
#' This parameter is named `y` to signify its role as the vertical axis of the scatter plot.
#' @param x_label Optional. A string for labeling the x-axis. If not provided, the name of the x variable is used.
#' @param y_label Optional. A string for labeling the y-axis. If not provided, the name of the y variable is used.
#' @param colour Optional. A string indicating the name of a column to colour the points in the scatter plot, or a specific colour value. It has a default value of "orchid4"
#' @param ... Additional parameters to be passed to the `geom_point()` function from ggplot2.
#' @return A ggplot object representing the scatter plot of the specified variables.
#' The plot displays points corresponding to the data in the x and y columns of the provided data frame.
#' @examples
#' library(palmerpenguins)
#' scatter(penguins, bill_length_mm, bill_depth_mm)
#' scatter(penguins, bill_length_mm, bill_depth_mm, x_label = "Bill Length", y_label = "Bill Depth")
#' @export
scatter <- function(data, x, y, x_label = NULL, y_label = NULL, colour = "orchid4", ...) {
  # Check if the required arguments are provided
  if (missing(data) || missing(x) || missing(y)) {
    stop("The 'data', 'x', and 'y' arguments are required and must be provided.")
  }

  # Ensure data is a data frame
  if (!is.data.frame(data)) {
    stop("The 'data' argument must be a data frame.")
  }

  # Capture the given column names for x and y
  x_name <- as.character(substitute(x))
  y_name <- as.character(substitute(y))

  # Check if the given column names are variables in the data frame
  if (any(!c(x_name, y_name) %in% colnames(data))) {
    stop("Both ", x_name , " and ", y_name, " must be valid column names in the provided data frame.")
  }

  # Remove rows with NA values
  data_clean <- stats::na.omit(data)

  # See if any valid data remains after dropping NA values
  if (nrow(data_clean) == 0) {
    stop("The selected columns contain no valid data after removing NA values.")
  }

  # Check if both selected columns are numeric
  if(!is.numeric(dplyr::pull(data_clean, {{x}})) || !is.numeric(dplyr::pull(data_clean, {{y}})))
    {
    stop('Sorry, but this function only works for numeric data!\n',
         'The first vector is of class: ', class(dplyr::pull(data_clean, {{x}})),
         '\nThe second vector is of class: ', class(dplyr::pull(data_clean, {{y}})))
    }

  # Set default x and y labels if not provided
  if (is.null(x_label)) {
    x_label <- x_name
  }
  if (is.null(y_label)) {
    y_label <- y_name
  }

  # Create the base scatter plot using the specified x and y variables.
  plot <- ggplot2::ggplot(data_clean, ggplot2::aes(x = {{x}}, y = {{y}}))

  # Check if the 'colour' argument corresponds to a column name in the data frame.
  # This allows users to specify a variable to color the points in the scatter plot.
  if (colour %in% colnames(data_clean)) {
    # If 'colour' is a valid column name, convert it into a symbol
    # This allows for dynamic referencing of the column within ggplot aesthetics
    colour_var <- as.name(colour)
    # Use the column specified in 'colour_group' for point colouring.
    plot <- plot + ggplot2::geom_point(ggplot2::aes(colour = !!colour_var),...)
  }

  else{
    # If 'colour' is not a column name, use it as a specific colour for the points.
    plot <- plot + ggplot2::geom_point(colour = colour,...)
  }

  # Add labels for the plot title and axes, and apply a minimal theme
  plot <- plot +
    ggplot2::labs(title = paste("Scatter Plot of", x_label, "vs", y_label),
         x = x_label,
         y = y_label) +
    ggplot2::theme_minimal()

  # Display the constructed plot to the user.
  print(plot)
}
