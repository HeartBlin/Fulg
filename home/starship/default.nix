{ configHM, lib, ... }: let 
  cfg = configHM.home;
in {
  config = lib.mkIf ( cfg.shell.starship == true ) {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        scan_timeout = 10;
        git_commit.tag_symbol = " tag ";
        format = "$directory$git_branch$git_metrics$git_commit$git_state$git_status$all";

        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[ε](bold red)";
        };

        git_branch = {
          style = "bold purple";
          symbol = "";
        };

        git_metrics = {
          added_style = "bold yellow";
          deleted_style = "bold red";
          disabled = false;
        };

        aws.symbol = "AWS ";
        bun.symbol = "Bun ";
        c.symbol = "C ";
        cobol.symbol = "Cobol ";
        conda.symbol = "Conda ";
        crystal.symbol = "Crystal ";
        cmake.symbol = "Cmake ";
        daml.symbol = "Daml ";
        dart.symbol = "Dart ";
        deno.symbol = "Deno ";
        dotnet.symbol = ".NET ";
        directory.read_only = " ro";
        docker_context.symbol = "Docker ";
        elixir.symbol = "Elixir ";
        elm.symbol = "Elm ";
        golang.symbol = "Go ";
        guix_shell.symbol = "Guix ";
        hg_branch.symbol = "Hg ";
        java.symbol = "Java ";
        julia.symbol = "Julia ";
        kotlin.symbol = "Kotlin ";
        lua.symbol = "Lua ";
        memory_usage.symbol = "Memory ";
        meson.symbol = "Meson ";
        nim.symbol = "Nim ";
        nix_shell.symbol = "Nix ";
        ocaml.symbol = "OCaml ";
        opa.symbol = "Opa ";
        nodejs.symbol = "NodeJS ";
        package.symbol = "Pkg ";
        perl.symbol = "Perl ";
        php.symbol = "php ";
        pulumi.symbol = "Pulumi ";
        purescript.symbol = "PureScript ";
        python.symbol = "Python ";
        raku.symbol = "Raku ";
        ruby.symbol = "Ruby ";
        rust.symbol = "Rust ";
        scala.symbol = "Scala ";
        spack.symbol = "Spack ";
        sudo.symbol = "Sudo ";
        swift.symbol = "Swift ";
        terraform.symbol = "Terraform ";
        zig.symbol = "Zig ";
      };
    };
  };
}