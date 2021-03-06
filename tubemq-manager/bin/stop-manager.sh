# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions an
# limitations under the License.

SIGNAL=${SIGNAL:-TERM}

if [[ $(uname -s) == "OS/390" ]]; then
    if [ -z $JOBNAME ]; then
        JOBNAME="TubeMQManager"
    fi
    PIDS=$(ps -A -o pid,jobname,comm | grep -i $JOBNAME | grep java | grep -v grep | awk '{print $1}')
else
    PIDS=$(jcmd  | grep -i 'TubeMQManager'  | awk '{print $1}')
fi

if [ -z "$PIDS" ]; then
  echo "No tubemq manager server to stop"
  exit 1
else
  kill -s $SIGNAL $PIDS
  echo "stop tubemq manager .... $PIDS"
fi
