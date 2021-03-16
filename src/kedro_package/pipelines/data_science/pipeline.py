from kedro.pipeline import node, Pipeline
from kedro_package.pipelines.data_science.nodes import (
    sample_func
)


def create_pipeline(**kwargs):
    return Pipeline(
        [
            node(
                func=sample_func,
                inputs='parameters',
                outputs=None,
            ),
        ]
    )
