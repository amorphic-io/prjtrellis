load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

_BUILD = """
licenses(["unencumbered"])

exports_files([
    "devices.json",
    "LICENSE",
] + glob([
    "ECP5/**/*",
]))

filegroup(
    name = "files",
    srcs = glob([
        "*",
        "**/*",
    ]),
    visibility = ["//visibility:public"],
)
"""

def _prjtrellis_db_impl(module_ctx):
    root_direct_deps = []
    name = "prjtrellis_db"
    for module in module_ctx.modules:
        if module.is_root:
            root_direct_deps.append(name)

    git_repository(
        name = name,
        commit = "4dda149b9e4f1753ebc8b011ece2fe794be1281a",
        remote = "https://github.com/YosysHQ/prjtrellis-db",
        build_file_content = _BUILD,
    )

    return module_ctx.extension_metadata(
        root_module_direct_deps = root_direct_deps,
        root_module_direct_dev_deps = [],
    )

prjtrellis_db = module_extension(
    implementation = _prjtrellis_db_impl,
)
