class Ptxlint < Formula
  desc "Static analysis and lints for NVIDIA PTX, no GPU needed"
  homepage "https://github.com/rustq/ptxlint"
  url "https://github.com/rustq/ptxlint/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "d4ebe21be129434464384e3d670a94f55a8651b7788e2bdc8ba94d125f673bc6"
  license "MIT"
  head "https://github.com/rustq/ptxlint.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # A kernel with an array in local memory, which is PTX001.
    (testpath/"kernel.ptx").write <<~PTX
      .version 8.0
      .target sm_80
      .address_size 64

      .visible .entry demo(
      	.param .u64 demo_param_0
      )
      {
      	.reg .b32 	%r<3>;
      	.reg .b64 	%rd<3>;
      	.local .align 4 .b8 	__local_depot0[64];

      	ld.param.u64 	%rd1, [demo_param_0];
      	mov.u32 	%r1, %tid.x;
      	st.local.b32 	[%rd2], %r1;
      	ret;
      }
    PTX

    output = shell_output("#{bin}/ptxlint --no-color #{testpath}/kernel.ptx")
    assert_match "demo", output
    assert_match "PTX001", output
    assert_match "64 bytes of local memory", output

    # --deny makes a firing lint exit 1; without it the exit code stays 0.
    shell_output("#{bin}/ptxlint --deny error #{testpath}/kernel.ptx", 1)
    shell_output("#{bin}/ptxlint #{testpath}/kernel.ptx")
  end
end
