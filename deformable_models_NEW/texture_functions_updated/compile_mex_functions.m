% compile mex files
mex -largeArrayDims biadjacency_matrix.cpp
mex build_km_tree.cpp % based on Euclidean distance
mex search_km_tree.cpp % based on Euclidean distance
