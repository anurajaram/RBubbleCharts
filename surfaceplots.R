# Author - Anupama Rajaram
# Program Description - 3D surface plots in R

# (1) using package plotly for 3D plots
library(plotly)
# volcano is a numeric matrix that ships with R
plot_ly(z = volcano, type = "surface")
v = as.data.frame( volcano)


# (2) using package "lattice" for 3D plots for geometric functions and "flower" plots 
x = seq(-7,25, 0.4)
  y=x
  j=length(x)
  z=matrix(nrow=j,ncol=j)
  
  for (i in 1:j) 
    {   for (k in 1:j) {
         z[i,k]=sin(sqrt(x[i]**2 + y[k]**2))
          }
  }
  require(lattice)
  wireframe(z,drape=TRUE)
  

# (3) rainbow colored "lego-style" globe using plot3D package
  spheresurf3D (colvar = matrix(nrow = 50, ncol = 50, data = 1:50, byrow = TRUE),
                phi = 0, theta = 0,
                col = NULL, NAcol = "white", breaks = NULL,
                border = NA, facets = TRUE, contour = FALSE,
                colkey = NULL, resfac = 1,
                panel.first = NULL, clim = NULL, clab = NULL, bty = "n",
                lighting = FALSE, shade = NA, ltheta = -135, lphi = 0,
                inttype = 1, full = FALSE, add = FALSE, plot = TRUE)
