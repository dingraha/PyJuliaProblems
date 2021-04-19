module PyJuliaProblems

using PyCall

# Path to this module.
const module_path = splitdir(@__FILE__)[1]

path_to_pyjulia_mwe = module_path
const pyjulia_mwe = PyNULL()

function __init__()
    # https://stackoverflow.com/questions/35288021/what-is-the-equivalent-of-imp-find-module-in-importlib
    importlib = PyCall.pyimport("importlib")
	loader_details = (
		importlib.machinery.SourceFileLoader,
		importlib.machinery.SOURCE_SUFFIXES)
    finder = importlib.machinery.FileFinder(path_to_pyjulia_mwe, loader_details)
	specs = finder.find_spec("pyjulia_mwe")
	pyjulia_mwe_mod = importlib.util.module_from_spec(specs)
	specs.loader.exec_module(pyjulia_mwe_mod)
	copy!(pyjulia_mwe, pyjulia_mwe_mod)
end

function doit()
    @show pyjulia_mwe.test1(0.0)
end

end # module
