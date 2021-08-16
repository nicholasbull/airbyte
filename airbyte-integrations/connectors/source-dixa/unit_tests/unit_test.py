#
# MIT License
#
# Copyright (c) 2020 Airbyte
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

from datetime import datetime, timezone

import pytest
from source_dixa import utils
from source_dixa.source import ConversationExport

config = {"authenticator": "", "start_date": "2021-07-01", "api_token": "TOKEN", "batch_size": 1}


@pytest.fixture
def conversation_export():
    return ConversationExport(config)


def test_validate_ms_timestamp_with_valid_input():
    assert utils.validate_ms_timestamp(1234567890123) == 1234567890123


def test_validate_ms_timestamp_with_invalid_input_type():
    with pytest.raises(ValueError):
        assert utils.validate_ms_timestamp(1.2)


def test_validate_ms_timestamp_with_invalid_input_length():
    with pytest.raises(ValueError):
        assert utils.validate_ms_timestamp(1)


def test_ms_timestamp_to_datetime():
    assert utils.ms_timestamp_to_datetime(1625312980123) == datetime(
        year=2021, month=7, day=3, hour=11, minute=49, second=40, microsecond=123000, tzinfo=timezone.utc
    )


def test_datetime_to_ms_timestamp():
    assert (
        utils.datetime_to_ms_timestamp(
            datetime(year=2021, month=7, day=3, hour=11, minute=49, second=40, microsecond=123000, tzinfo=timezone.utc)
        )
        == 1625312980123
    )


def test_add_days_to_ms_timestamp():
    assert utils.add_days_to_ms_timestamp(days=1, ms_timestamp=1625312980123) == 1625399380123


def test_stream_slices_without_state(conversation_export):
    conversation_export.end_timestamp = 1625259600000  # 2021-07-03 00:00:00 + 1 ms

    expected_slices = [
        {"updated_after": 1625086800000, "updated_before": 1625173200000},
        {"updated_after": 1625173200000, "updated_before": 1625259600000}
    ]

    actual_slices = conversation_export.stream_slices()
    assert actual_slices == expected_slices


def test_stream_slices_without_state_large_batch():

    updated_config = config
    updated_config["batch_size"] = 31

    conversation_export = ConversationExport(updated_config)
    conversation_export.end_timestamp = 1625259600000  # 2021-07-03 00:00:00 + 1 ms
    expected_slices = [{'updated_after': 1625086800000, 'updated_before': 1625259600000}]  # 2021-07-01 12:00:00 """
    actual_slices = conversation_export.stream_slices()
    assert actual_slices == expected_slices


def test_stream_slices_with_state(conversation_export):
    conversation_export.end_timestamp = 1625259600001  # 2021-07-03 00:00:00 + 1 ms
    expected_slices = [{"updated_after": 1625220000000, "updated_before": 1625259600001}]  # 2021-07-01 12:00:00
    actual_slices = conversation_export.stream_slices(stream_state={"updated_at": 1625220000000})  # # 2021-07-02 12:00:00
    assert actual_slices == expected_slices


def test_stream_slices_with_start_timestamp_larger_than_state():
    #
    # Test that if start_timestamp is larger than state, then start at start_timestamp.
    #
    updated_config = config
    updated_config["start_date"] = "2021-12-01"
    updated_config["batch_size"] = 31

    conversation_export = ConversationExport(updated_config)
    conversation_export.end_timestamp = 1638352800001  # 2021-12-01 12:00:00 + 1 ms
    expected_slices = [{"updated_after": 1638309600000, "updated_before": 1638352800001}]  # 2021-07-01 12:00:00 """
    actual_slices = conversation_export.stream_slices(stream_state={"updated_at": 1625216400000})  # # 2021-07-02 12:00:00
    assert actual_slices == expected_slices


def test_get_updated_state_without_state(conversation_export):
    expected = {"updated_at": 1638309600000}
    actual = conversation_export.get_updated_state(current_stream_state=None, latest_record={"updated_at": 1625259600001})
    print(f'Actual: {actual}')
    assert actual == expected


def test_get_updated_state_with_bigger_state(conversation_export):
    expected = {"updated_at": 1625263200000}
    actual = conversation_export.get_updated_state(
        current_stream_state={"updated_at": 1625263200000}, latest_record={"updated_at": 1625220000000}
    )
    assert actual == expected


def test_get_updated_state_with_smaller_state(conversation_export):
    expected = {"updated_at": 1625263200000}
    actual = conversation_export.get_updated_state(
        current_stream_state={"updated_at": 1625220000000}, latest_record={"updated_at": 1625263200000}
    )
    assert actual == expected
