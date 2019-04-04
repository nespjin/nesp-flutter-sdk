/*
 * Copyright (c) 2019  NESP Technology Corporation. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU General Public License,
 * version 2, as published by the Free Software Foundation.
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License.See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * If you have any questions or if you find a bug,
 * please contact the author by email or ask for Issues.
 *
 * Author:JinZhaolu <1756404649@qq.com>
 */
part of nesp_app;

/**
 *
 *
 * @team NESP Technology
 * @author <a href="mailto:1756404649@qq.com">靳兆鲁 Email:1756404649@qq.com</a>
 * @time: Created 19-4-3 下午2:22
 * @project fish_movie
 **/

///替换
 pushReplacementNamed(BuildContext context, String routeName) {
  Navigator.pushReplacementNamed(context, routeName);
}

///切换无参数页面
 pushNamed(BuildContext context, String routeName) {
  Navigator.pushNamed(context, routeName);
}

