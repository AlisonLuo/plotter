% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scatter.R
\name{scatter}
\alias{scatter}
\title{Create a scatter plot from a dataframe}
\usage{
scatter(data, x, y, x_label = NULL, y_label = NULL, colour = "orchid4", ...)
}
\arguments{
\item{data}{A dataframe containing the variables to be plotted. This parameter is named \code{data}
because it represents the main data structure required for plotting.}

\item{x}{The name of the variable for the x-axis, specified as a column in the dataframe.
This parameter is named \code{x} to clearly indicate its role as the horizontal axis of the scatter plot.}

\item{y}{The name of the variable for the y-axis, specified as a column in the dataframe.
This parameter is named \code{y} to signify its role as the vertical axis of the scatter plot.}

\item{x_label}{Optional. A string for labeling the x-axis. If not provided, the name of the x variable is used.}

\item{y_label}{Optional. A string for labeling the y-axis. If not provided, the name of the y variable is used.}

\item{colour}{Optional. A string indicating the name of a column to colour the points in the scatter plot, or a specific colour value. It has a default value of "orchid4"}

\item{...}{Additional parameters to be passed to the \code{geom_point()} function from ggplot2.}
}
\value{
A ggplot object representing the scatter plot of the specified variables.
The plot displays the data points based on the values in the x and y columns of the provided dataframe.
}
\description{
The \code{scatter()} function creates a scatter plot from two specified numeric columns
in a dataframe. Users can customize the plot by adjusting axis labels, colors,
and additional \code{geom_point()} function parameters.
}
\details{
This function is a wrapper around the \code{drop_na()} function in the \code{tidyr} package, the \code{pull()} function in the \code{dplyr} package, as well as the \code{ggplot()} and \code{geom_point()} functions in the \code{ggplot2} package.
}
\examples{
library(palmerpenguins)
scatter(penguins, bill_length_mm, bill_depth_mm)
scatter(penguins, bill_length_mm, bill_depth_mm, x_label = "Bill Length", y_label = "Bill Depth")
}
