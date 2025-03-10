# Copyright edalize contributors
# Licensed under the 2-Clause BSD License, see LICENSE for details.
# SPDX-License-Identifier: BSD-2-Clause

from edalize.flows.generic import Generic


class Gowin(Generic):
    """Official Gowin FPGA toolchain"""

    argtypes = []

    @classmethod
    def get_flow_options(cls):
        return {k: v for k, v in cls.FLOW_OPTIONS.items() if k != "tool"}

    @classmethod
    def get_tool_options(cls, flow_options):
        flow = flow_options.get("frontends", []).copy() + ["gowin"]

        return cls.get_filtered_tool_options(flow, cls.FLOW_DEFINED_TOOL_OPTIONS)

    def configure_flow(self, flow_options):
        self.flow_options["tool"] = "gowin"
        return super().configure_flow(flow_options)
